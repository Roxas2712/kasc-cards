# KASC Cards — NG+ performance hotfix

Updated Red, Blue and Yellow Cards now require **KASC 6.7.0-rc.4**, containing
the Legacy Bank per-step lag fix and removal of KASC diagnostic/repro markers.
The mod is available separately from the [KASC release](https://github.com/Roxas2712/kanto-ascendant/releases/tag/v6.7.0-rc.4).

VASC remains pinned to **RC66g / 3.0.0-rc.15**. Both archives are SHA256-pinned.
All three Card IDs, artwork, options, seal and save scope are preserved.

Close the game, keep/back up saves and mod_storage, import the new Card for
your edition, update its pinned KASC mod, then restart. Do not delete the Bank.
The Card files contain configuration/art only; they do not contain ROMs or
duplicate either mod. Existing RC3 Cards remain available for rollback.

Index: https://raw.githubusercontent.com/Roxas2712/kasc-cards/main/kasc-card-index.json

Native Cart codec roundtrip, identity/art/options and index parsing checks pass
for all three editions. KASC's archive/NG+ regression tests pass. The original
macOS test measured recurring step processing falling from about 2 seconds to
2–6 ms; Windows confirmation remains pending. Initial migration/loading may pause.
