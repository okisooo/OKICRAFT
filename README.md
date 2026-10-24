# OKICRAFT

a minecraft modpack for exploring, building, and automating together, with expanded terrain, farming, storage, and proximity voice chat.

[download the pack](https://github.com/okisooo/OKICRAFT/releases/download/mrpack/OKICRAFT.1.0.0-beta3.mrpack) · [release notes](https://github.com/okisooo/OKICRAFT/releases/tag/mrpack) · [server setup notes](SERVER_SETUP.md)

the published `1.0.0-beta3` pack targets minecraft `1.20.1` and forge `47.4.10`. this is a beta release.

## start playing

1. download `OKICRAFT.1.0.0-beta3.mrpack` using the pack link above.
2. import it into a launcher with `.mrpack` support. in prism launcher, choose `Add Instance` → `Import`, then select the file. the [launcher import guide](https://prismlauncher.org/wiki/help-pages/zip-import/) explains the process.
3. let the launcher install the pack's dependencies, then launch the imported instance.

use the released `.mrpack` for installation. GitHub's `Code` → `Download ZIP` gives you this repository's configuration and tooling, rather than the launcher import pack.

## what's in the released pack

these highlights are listed in the released pack's `modrinth.index.json` manifest:

| for | included mods |
| --- | --- |
| terrain & exploration | `Terralith`, `Biomes O' Plenty` |
| mechanical automation | `Create` |
| item storage | `Applied Energistics 2` |
| building & decoration | `Handcrafted`, `Supplementaries` |
| food & farming | `Farmer's Delight` |
| proximity voice chat | `Simple Voice Chat` |

## configuration & server notes

this repository holds the pack's shared [configuration](config), [default configuration](defaultconfigs), and [server tooling](scripts). see the [server setup notes](SERVER_SETUP.md) when preparing a server.

the [feature overview](MODPACK_SUMMARY.md) provides more background, but some entries differ from the published beta. use the released `.mrpack` and its manifest as the reference for that version.

## more from OKISO

- [okiso.net](https://okiso.net/) — music, commissioned artwork, and official links.
- [website source](https://github.com/okisooo/site) — the frontend behind the site.
- [DesktopMateController](https://github.com/okisooo/DesktopMateController) — windows tray controls for `DesktopMate`.
