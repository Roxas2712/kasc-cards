local repo=os.getenv('CARDS_REPO') or '.'
local root=os.getenv('RELEASE_ROOT') or repo..'/verification-data'
local engine=assert(os.getenv('GEN1RECOMP_DIR'),'GEN1RECOMP_DIR required')
package.path=engine..'/?.lua;'..engine..'/?/init.lua;'..package.path
local C=require('src.carts.CartManifest');local I=require('src.mods.ModIndex');local J=require('src.link.Json');local S=require('src.core.SaveSerializer');local Sem=require('src.mods.Semver')
local function read(p)local f=assert(io.open(p,'rb'));local b=f:read('*a');f:close();return b end
local receipts=assert(J.decode(read(root..'/PACKAGE-RECEIPTS.json')))
local feed=assert(I.parse(read(repo..'/kasc-card-index.json'),J));assert(#feed.carts==3 and #feed.mods==6)
local report={status='PASS',scope='native Card codec, exact-pin index resolution, save identity/art/options preservation and KASC compatibility range',cards={}}
for _,ed in ipairs({'red','blue','yellow'})do
 local before=assert(C.decode(read(repo..'/cards/kanto-ascendant-'..ed..'-1.3.0-rc.5.g1rcart')))
 local after=assert(C.decode(read(repo..'/cards/kanto-ascendant-'..ed..'-1.3.0-rc.6.g1rcart')))
 assert(after.version=='1.3.0-rc.6' and C.publishable(after));assert(C.labelArtBytes(before)==C.labelArtBytes(after))
 assert(C.hash(assert(C.decode(C.encode(after))))==C.hash(after))
 local row;for _,r in ipairs(feed.carts)do if r.id==after.id then row=r end end
 assert(row and row.version==after.version and row.downloadURL:find('v1.3.0-rc.6/',1,true))
 for i,pin in ipairs(after.mods)do
  local expected=pin.id=='kanto_ascendant' and '6.7.0-rc.6' or '3.0.2'
  local hash=pin.id=='kanto_ascendant' and receipts.kasc.sha256 or receipts.vasc.sha256
  assert(pin.version==expected and pin.sha256==hash)
  assert(row.mods[i].version==expected and row.mods[i].sha256==hash)
  local release
  for _,m in ipairs(feed.mods)do if m.id==pin.id and Sem.compare(I.displayVersion(m),pin.version)==0 then release=I.releaseFor(m);break end end
  assert(release and release.version==expected)
  assert(release.zip.url:find(pin.id=='kanto_ascendant' and '/v6.7.0-rc.6/' or '/v3.0.2/',1,true))
 end
 report.cards[#report.cards+1]={id=after.id,version=after.version,mods=after.mods,artBytes=#C.labelArtBytes(after)}
 -- A deep decode keeps the receipt's pins independent of these comparisons.
 local restored=assert(C.decode(C.encode(after)));restored.version=before.version
 for i,pin in ipairs(restored.mods)do pin.version=before.mods[i].version;pin.sha256=before.mods[i].sha256 end
 assert(S.encode(restored)==S.encode(before),'Card changed outside versions/hashes')
 print('PASS native Card roundtrip, identity, art, options, save scope and exact feed pins: '..ed)
end
local manifest=assert(J.decode(read(root..'/kasc-manifest.json')));local spec
for _,c in ipairs(manifest.conflicts)do if c:find('VOXEL_ASCENDANT@',1,true)==1 then spec=c:match('@(.*)')end end
assert(not Sem.satisfies('3.0.2',spec),'new VASC blocked')
for _,v in ipairs({'3.0.0-rc.12','3.0.0-rc.13','3.0.0-rc.14','3.0.0-rc.15'})do assert(not Sem.satisfies(v,spec))end
local allow=manifest.exclusive.allow_packages[1].version
for _,v in ipairs({'3.0.0-rc.15.1','3.0.0-rc.16','3.0.0','3.0.2','3.0.2','4.0.0','9.0.0-rc.1'}) do
 assert(not Sem.satisfies(v,spec),'newer VASC blocked: '..v)
 assert(Sem.satisfies(v,allow),'newer VASC missing package admission: '..v)
end
local R=assert(loadfile(root..'/voxel_renderer_compat.lua'))()()
for _,v in ipairs({'3.0.0-rc.15.1','3.0.2','3.0.2','4.0.0','9.0.0-rc.1'}) do
 assert(Sem.satisfies(v,R.approvedVersionRanges.VOXEL_ASCENDANT.range),'newer VASC runtime blocked: '..v)
end
local f=assert(io.open(repo..'/verification.json','w'));f:write(assert(J.encode(report))..'\n');f:close()
print('PASS explicit KASC admission and distinct VASC update version; higher VASC versions are admitted at all three gates')
