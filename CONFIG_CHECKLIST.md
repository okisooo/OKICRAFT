# OKICRAFT Modpack - Configuration Checklist & Recommendations

This document outlines configuration items that need attention before publishing to Modrinth.

---

## ✅ Completed Configurations

### Better Compatibility Checker (`config/bcc-common.toml`)
- [x] Modpack name set to "OKICRAFT"
- [x] Version set to "1.0.0"
- [x] Project ID not needed for Modrinth (BCC is CurseForge-specific)

### Default Configs (`defaultconfigs/`)
- [x] Voice Chat server defaults created
- [x] Lootr defaults created  
- [x] Waystones defaults created

---

## ⚠️ Items Requiring Your Attention

### 1. Modrinth Project Setup
1. Create your project at https://modrinth.com/dashboard/projects
2. Set project type to "Modpack"
3. Add appropriate categories and tags
4. Upload your pack's icon/logo

### 2. Custom Loading Screen (Optional)
The `drippyloadingscreen` mod is installed but has minimal config.
To customize:
- Add background images to `config/drippyloadingscreen/`
- Edit the loading screen configuration

### 3. Custom Main Menu (Optional)  
FancyMenu is installed but in default mode.
To customize:
- Set `modpack_mode = 'true'` in `config/fancymenu/options.txt`
- Create custom menu layouts in `config/fancymenu/customization/`

### 4. Discord/Community Links
Consider adding:
- Discord Rich Presence integration
- Links in the modpack description

---

## 📋 Recommended Pre-Release Checklist

### Performance Testing
- [ ] Test with minimum recommended RAM (6GB)
- [ ] Test with shaders enabled
- [ ] Verify startup time is acceptable
- [ ] Test multiplayer server connectivity

### Content Verification
- [ ] Verify all mods load without errors
- [ ] Check JEI for recipe conflicts
- [ ] Test voice chat connectivity
- [ ] Verify all biomes generate correctly

### Documentation
- [ ] Update MODPACK_SUMMARY.md with final links
- [ ] Create CurseForge description from summary
- [ ] Add installation instructions
- [ ] Add known issues section if applicable

---

## 🔧 Optional Configuration Tweaks

### Voice Chat - Increase Range (for larger communities)
In `config/voicechat/voicechat-server.properties`:
```properties
max_voice_distance=64.0   # Default is 48.0
whisper_distance=32.0     # Default is 24.0
```

### Waystones - Make More Common
In `config/waystones-common.toml`:
```toml
frequency = 20   # Lower = more common (default 25)
forceSpawnInVillages = true  # Guarantee waystones in villages
```

### Quark - Disable Conflicting Features
If you experience issues, edit `config/quark-common.toml`:
- Disable features that conflict with Create
- Disable features that conflict with other mods

### Apotheosis - Adjust Difficulty
In `config/apotheosis/adventure.cfg`:
- Adjust boss difficulty
- Modify loot quality settings
- Configure spawner modifications

### Lootr - Enable Chest Decay (For SMP Balance)
In `config/lootr-common.toml`:
```toml
decay_dimensions = ["minecraft:overworld"]
decay_value = 72000   # 1 hour before chests decay
```

---

## 📦 Export Instructions

### Modrinth-Only Strategy
Your modpack is distributed exclusively on **Modrinth**, which means:
- ✅ **Yes Steve Model included** (Modrinth-exclusive mod)
- ✅ All mods available via Modrinth manifest
- ✅ Proper licensing compliance (no direct redistribution)
- ✅ Smaller download sizes (launchers fetch dependencies)
- ✅ Works with Modrinth App, Prism Launcher, ATLauncher, MultiMC

### Dependencies (Added via Modrinth Project Settings)
When uploading, add these as **optional dependencies**:

**Shaders:**
- Complementary Reimagined
- Complementary Unbound  
- Miniature Shader

**Resource Packs:**
- Fresh Animations
- Beautiful Enchanted Books
- Beautiful Potions
- Darkmode Colourful Containers
- Quark Programmer Art

### Export Workflow
1. Export as `.mrpack` from Prism Launcher / ATLauncher / etc.
2. Upload to Modrinth
3. Add shaders/resource packs as optional dependencies
4. For server pack: Same export, just remove client-only mods

### Client-Only Mods to Remove for Server Pack:
```
- Oculus (shaders)
- Embeddium (rendering)  
- FancyMenu, Drippy Loading Screen (menus)
- Better Advancements (UI)
- Controlling (UI)
- Configured (UI)
- Mouse Tweaks (client input)
- Skin Layers 3D (cosmetic)
- Chat Heads (cosmetic)
```

### Required Files to Include:
```
config/                   # All configuration files
defaultconfigs/           # Server-side defaults
fancymenu_data/          # Custom menu layouts
```

### Files Handled by Manifests (NOT in repo):
```
mods/                     # Downloaded via manifest
resourcepacks/            # Added as dependencies
shaderpacks/             # Added as dependencies
```

### Files to EXCLUDE:
```
saves/                   # Player worlds
logs/                    # Log files
crash-reports/           # Crash reports
journeymap/              # Map data (personal)
xaero/                   # Xaero map data (personal)
screenshots/             # Player screenshots
schematics/              # Personal schematics
*.old                    # Backup files
```

---

## 🏷️ Suggested Modrinth Tags

- Adventure
- Technology
- Magic  
- Multiplayer
- Building
- Optimization
- Utility

---

## 📝 Version History Template

### v1.0.0 - Initial Release
- Initial public release
- 117 mods included (including Yes Steve Model!)
- 4 resource packs (via dependencies)
- 3 shader options (via dependencies)

---

*Generated for OKICRAFT Modpack - Modrinth Distribution - December 2024*
