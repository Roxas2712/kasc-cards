# KASC Cards

Custom Cards for Kanto Ascendant + Voxel Ascendant in Gen1Recomp. This repository contains launch configuration and artwork only, with no ROMs or mod-code copies.

| Red | Blue | Yellow |
| --- | --- | --- |
| ![Red](art/red.png) | ![Blue](art/blue.png) | ![Yellow](art/yellow.png) |

[Download Cards 1.3.0-rc.5](https://github.com/Roxas2712/kasc-cards/releases/tag/v1.3.0-rc.5)

Updated Red, Blue and Yellow Cards pin **KASC 6.7.0-rc.5** and **VASC 3.0.0-rc.15.1** with their exact ZIP SHA256 checksums. VASC automatically retries failed HD content requests through the additional hosting address. KASC adds only the matching version admission and retains the RC4 NG+ performance fix.

Download the `.g1rcart` for your edition, import it, update both pinned mods and restart the game. Keep saves and mod_storage. All three Card IDs, artwork, options, seal and save scope are preserved. Cards contain configuration/art only, with no ROMs or mod-code copies.

- [KASC mod](https://github.com/Roxas2712/kanto-ascendant/releases/tag/v6.7.0-rc.5)
- [VASC mod](https://github.com/Roxas2712/voxel-ascendant/releases/tag/v3.0.0-rc.15.1)
- Index: https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json

Native Cart roundtrip, identity/art/options equality, exact-pin index resolution and KASC compatibility checks pass for all three editions. The VASC download transport was exercised on desktop; physical-mobile and Brazil-specific behavior remain unverified. Both hosting routes use Cloudflare. Existing RC4 Cards and old pinned mod entries remain available for rollback.

## Installation

Add the index URL above under the launcher's Find mods sources. Import your edition's Card and install/update both pinned mods. If automatic installation is unavailable, manually import the two exact mod ZIPs from the linked releases. GitHub's automatic Source code archives are not installable mods.

Use your own matching ROM and a host with Custom Cards and mod-index support (tested host: 0.2.56). The existing Card IDs preserve their save scope. Ordinary non-Card saves are not automatically migrated into a Card scope.

[Deutsche Anleitung](INSTALLATION-DE.md)
