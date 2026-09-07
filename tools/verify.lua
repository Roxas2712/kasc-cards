-- Run from the repository root with the native host on LUA_PATH.
local C=require('src.carts.CartManifest')
local I=require('src.mods.ModIndex')
local J=require('src.link.Json')
local function read(p)local f=assert(io.open(p,'rb'));local s=f:read('*a');f:close();return s end
local function write(p,s)local f=assert(io.open(p,'wb'));assert(f:write(s));f:close()end
local index=assert(I.parse(read('kasc-card-index.json'),J))
assert(#index.carts==3 and #index.mods==3)
local receipt={status='PASS',scope='Distribution-only; unchanged Cards and dependency pins',cards={}}
for n,e in ipairs({'red','blue','yellow'})do
  local filename='kanto-ascendant-'..e..'-1.3.0-rc.3.g1rcart'
  local cart=assert(C.decode(read('cards/'..filename)))
  assert(cart.id=='kanto_ascendant_'..e and cart.version=='1.3.0-rc.3')
  assert(cart.seal=='sealed' and #cart.mods==2 and C.publishable(cart))
  assert(cart.mods[1].id=='kanto_ascendant' and cart.mods[1].repo=='Roxas2712/kanto-ascendant')
  assert(cart.mods[1].version=='6.7.0-rc.3' and cart.mods[1].sha256=='77746d4b533d4f61bf0e0f49231f33b7ed9ca034fd84ee9d1c70578f72cc5069')
  assert(cart.mods[2].id=='VOXEL_ASCENDANT' and cart.mods[2].repo=='Roxas2712/voxel-ascendant')
  assert(cart.mods[2].version=='3.0.0-rc.15' and cart.mods[2].sha256=='e054242d9c56bb967bd0345d8ddd054d70c3b566a97f4be2f0e302f61c4bd3ea')
  assert(cart.load_order[1]==cart.mods[1].id and cart.load_order[2]==cart.mods[2].id)
  local row
  for _,c in ipairs(index.carts)do if c.id==cart.id then row=c end end
  assert(row and row.repo=='Roxas2712/kasc-cards')
  assert(row.downloadURL=='https://github.com/Roxas2712/kasc-cards/releases/download/v1.3.0-rc.3/'..filename)
  for _,pin in ipairs(cart.mods)do
    local release
    for _,m in ipairs(index.mods)do
      if m.id==pin.id and I.displayVersion(m)==pin.version then release=I.releaseFor(m);break end
    end
    assert(release and release.version==pin.version)
    assert(release.zip.url:find('https://github.com/'..pin.repo..'/releases/download/',1,true)==1)
  end
  local art=assert(C.labelArtBytes(cart));write('art/'..e..'.png',art)
  receipt.cards[#receipt.cards+1]={id=cart.id,version=cart.version,mods=cart.mods,artBytes=#art}
end
write('verification.json',assert(J.encode(receipt))..'\n')
print('PASS: native Cart codec, three unchanged identities, required pins, artwork and native index resolution')
