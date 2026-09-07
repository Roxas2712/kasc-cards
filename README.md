# KASC Cards

Custom Cards for **Kanto Ascendant + Voxel Ascendant** in Gen1Recomp.
Configuration and edition artwork only; no ROMs or duplicate mod code.

| Red | Blue | Yellow |
| --- | --- | --- |
| ![Red](art/red.png) | ![Blue](art/blue.png) | ![Yellow](art/yellow.png) |

[Download v1.3.0-rc.4 — NG+ performance hotfix](https://github.com/Roxas2712/kasc-cards/releases/tag/v1.3.0-rc.4)

The updated Cards pin [KASC 6.7.0-rc.4](https://github.com/Roxas2712/kanto-ascendant/releases/tag/v6.7.0-rc.4)
with the Legacy Bank lag fix and KASC diagnostic markers removed, plus
[VASC RC66g / 3.0.0-rc.15](https://github.com/Roxas2712/voxel-ascendant/releases/tag/v3.0.0-rc66g).
Both mod archive hashes are pinned. Card IDs, artwork, settings and save scope
remain identical to RC3. The Riolu/Lucario fix remains included.

## Installation

1. Close the game and back up saves **and mod_storage/Legacy Bank**.
2. Add this source under **Find mods**:

   https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json

3. Import the 1.3.0-rc.4 Card matching your own ROM edition, update its required
   KASC mod, then restart. Replace the previous KASC installation.

Manual installation: import the exact mod ZIPs linked above, then the Card.
Do not import GitHub's automatic Source code archives. Do not delete Bank data.
Non-Card saves do not automatically migrate to a Card's save scope.

## Validation and rollback

Native Cart codec roundtrip, exact dependency pins, edition artwork, identity,
options and index parsing checks pass for all three editions. See the linked
KASC release for the performance/regression results and remaining limits.
Windows player confirmation is pending; initial loading/migration may pause.
RC3 Cards and mod releases remain available for rollback.

[Release notes](RELEASE-NOTES-1.3.0-rc.4.md) · [Deutsche Anleitung](INSTALLATION-DE.md)

SHA256SUMS.txt covers the new Cards. The old distribution index in the KASC
repository is also updated to these Cards. Older exact mod pins remain listed.
