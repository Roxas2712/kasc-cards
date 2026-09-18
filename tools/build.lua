-- CARDS_REPO and GEN1RECOMP_DIR select the checkout and native host source.
local repo=os.getenv('CARDS_REPO') or '.'
local engine=assert(os.getenv('GEN1RECOMP_DIR'),'GEN1RECOMP_DIR required')
package.path=engine..'/?.lua;'..engine..'/?/init.lua;'..package.path
local C=require('src.carts.CartManifest');local J=require('src.link.Json')
local function read(p)local f=assert(io.open(p,'rb'));local b=f:read('*a');f:close();return b end
local function write(p,b)local f=assert(io.open(p,'wb'));f:write(b);f:close()end
local receipts=assert(J.decode(read(repo..'/verification-data/PACKAGE-RECEIPTS.json')))
for _,edition in ipairs({'red','blue','yellow'})do
 local cart=assert(C.decode(read(repo..'/cards/kanto-ascendant-'..edition..'-1.3.0-rc.21.g1rcart')))
 cart.version='1.3.0'
 for _,pin in ipairs(cart.mods)do
  local release=assert(receipts[pin.id=='kanto_ascendant' and 'kasc' or 'vasc'])
  pin.version=release.version;pin.sha256=release.sha256
 end
 assert(C.publishable(cart));write(repo..'/cards/kanto-ascendant-'..edition..'-1.3.0.g1rcart',C.encode(cart))
 print('BUILT '..edition..' 1.3.0')
end
