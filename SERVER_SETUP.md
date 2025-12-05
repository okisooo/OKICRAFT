# OKICRAFT Server Setup Guide

This guide explains how to set up the OKICRAFT server from the modpack source.

## Quick Start

1. Download and install Forge 1.20.1 server
2. Copy mods (excluding client-only mods listed below)
3. Copy `config/` and `defaultconfigs/` folders
4. Configure server.properties
5. Start server

---

## Client-Only Mods (DO NOT include on server)

These mods are client-side only and will crash or cause issues on a server:

```
# Rendering/Visual
embeddium-*.jar
oculus-*.jar
ImmediatelyFast-*.jar
skinlayers3d-*.jar
AmbientSounds_*.jar

# UI/HUD
appleskin-*.jar
chat_heads-*.jar
Controlling-*.jar
EnchantmentDescriptions-*.jar
Jade-*.jar
JourneyMap-*.jar (has server version if needed)
MouseTweaks-*.jar
NaturesCompass-*.jar (client-side features)
shulkerboxtooltip-*.jar
Xaeros_Minimap_*.jar
XaerosWorldMap_*.jar

# Menu/Loading Screen
fancymenu_*.jar
drippyloadingscreen_*.jar
konkrete_*.jar
melody_*.jar
YungsMenuTweaks-*.jar

# Resource Pack Dependent
ysm-*.jar (Yes Steve Model - client only)

# Performance (client-specific)
# Note: Some of these ARE needed on server, check each one
```

---

## Required Server Mods

All other mods should be included. Key server mods:

- **voicechat** - Requires server-side
- **Create** - Full server support
- **Applied Energistics 2** - Full server support
- **Thermal Series** - Full server support
- **All worldgen mods** - Required for world generation
- **Lootr** - Per-player loot (server-side)
- **Waystones** - Requires server-side

---

## Server Configuration

### Memory Allocation
```bash
# Recommended: 6-8GB for small servers
java -Xms4G -Xmx8G -jar forge-1.20.1-*.jar nogui
```

### Important Server Configs

#### `server.properties`
```properties
max-tick-time=120000
view-distance=10
simulation-distance=8
```

#### Voice Chat (`config/voicechat/voicechat-server.properties`)
```properties
port=24454
max_voice_distance=48.0
```

---

## Automated Server Pack Script

See `scripts/build-server-pack.ps1` for automated server pack generation.

