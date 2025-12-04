# OKICRAFT Modpack - Configuration Checklist & Recommendations

This document outlines configuration items that need attention before publishing to CurseForge.

---

## ✅ Completed Configurations

### Better Compatibility Checker (`config/bcc-common.toml`)
- [x] Modpack name set to "OKICRAFT"
- [x] Version set to "1.0.0"
- [ ] **ACTION NEEDED**: Update `modpackProjectID` after creating CurseForge project

### Default Configs (`defaultconfigs/`)
- [x] Voice Chat server defaults created
- [x] Lootr defaults created  
- [x] Waystones defaults created

---

## ⚠️ Items Requiring Your Attention

### 1. CurseForge Project Setup
After creating your CurseForge project:
1. Get your Project ID from the CurseForge project page
2. Update `config/bcc-common.toml`:
   ```toml
   modpackProjectID = YOUR_PROJECT_ID_HERE
   ```

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

### Git Branch Strategy
Your modpack uses separate branches for each platform:
- `main` - Development branch (includes everything)
- `modrinth` - Complete pack with Yes Steve Model
- `curseforge` - Pack without Yes Steve Model (CF-compatible)

### 1. For CurseForge
1. Ensure you're on the `curseforge` branch: `git checkout curseforge`
2. Export the profile from your launcher
3. Upload to CurseForge

### 2. For Modrinth
1. Ensure you're on the `modrinth` branch: `git checkout modrinth`
2. Export as `.mrpack` (Modrinth format)
3. Upload to Modrinth

### Required Files to Include:
```
mods/                     # All mod JARs (except non-CF mods for CF export)
config/                   # All configuration files
defaultconfigs/           # Server-side defaults
resourcepacks/            # Included resource packs
shaderpacks/             # Included shader packs
fancymenu_data/          # If using custom menus
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

## 🏷️ Suggested CurseForge Tags

- Exploration
- Tech
- Magic  
- Multiplayer
- Quests (if you add any)
- Building
- Quality of Life

---

## 📝 Version History Template

### v1.0.0 - Initial Release
- Initial public release
- 117 mods included
- 4 resource packs
- 3 shader packs

---

*Generated for OKICRAFT Modpack - December 2024*
