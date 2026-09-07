# KASC Cards — HD Download Fallback

Updated Red, Blue and Yellow Cards pin **KASC 6.7.0-rc.5** and **VASC 3.0.0-rc.15.1** with their exact ZIP SHA256 checksums. VASC automatically retries failed HD content requests through the additional hosting address. KASC adds only the matching version admission and retains the RC4 NG+ performance fix.

Download the `.g1rcart` for your edition, import it, update both pinned mods and restart the game. Keep saves and mod_storage. All three Card IDs, artwork, options, seal and save scope are preserved. Cards contain configuration/art only, with no ROMs or mod-code copies.

- [KASC mod](https://github.com/Roxas2712/kanto-ascendant/releases/tag/v6.7.0-rc.5)
- [VASC mod](https://github.com/Roxas2712/voxel-ascendant/releases/tag/v3.0.0-rc.15.1)
- Index: https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json

Native Cart roundtrip, identity/art/options equality, exact-pin index resolution and KASC compatibility checks pass for all three editions. The VASC download transport was exercised on desktop; physical-mobile and Brazil-specific behavior remain unverified. Both hosting routes use Cloudflare. Existing RC4 Cards and old pinned mod entries remain available for rollback.
