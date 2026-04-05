# ⚔️ TFS 1.8 Downgrade — Protocol 8.60

[![Build status](https://ci.appveyor.com/api/projects/status/github/Mateuzkl/forgottenserver-downgrade?branch=official&svg=true)](https://ci.appveyor.com/project/Mateuzkl/forgottenserver-downgrade)

**Engine:** TFS 1.8 | **Protocol:** 8.60  
**Developed & Optimized by** [Mateuzkl](https://github.com/Mateuzkl)

> Based on [Nekiro's TFS 1.5 Downgrades](https://github.com/nekiro/TFS-1.5-Downgrades), forked from [MillhioreBT's downgrade](https://github.com/MillhioreBT/forgottenserver-downgrade).  
> Fully reworked — all systems, optimizations, and custom features by Mateuzkl.

TFS 1.8 for 8.60 client — uses ClientID only. Items, maps, and scripts all reference the ClientID from the client's `.dat` file directly. No ServerID conversion layer.

---

## 🎯 ClientID Implementation (Full .dat Support)

This server uses **ClientID only** — all items are identified by their ClientID from the client's `.dat` file:

- **ClientID Only**: No ServerID. Items, maps (OTBM), Lua scripts, and database tables all use the ClientID directly.
- **Full .dat System**: Reads item definitions from the client's `.dat` file, like Canary and Crystal Server.
- **No Conversion Layer**: There is no ServerID/ClientID mapping — the ID you see in the client is the same ID used everywhere in the server.

This eliminates the traditional ServerID/ClientID mismatch, making content creation and debugging simpler.



To edit maps compatible with this ClientID system, use the modified RME: **[Download RME-CLIENTID](https://github.com/Mateuzkl/RME-CLIENTID)**

---

## 🚀 Overview

This is a **custom modified version** of The Forgotten Server, downgraded to protocol 8.60 but running on the modern TFS 1.8 engine. It includes numerous exclusive systems and improvements.

---

## 🎮 New Systems & Features

This custom version includes several enhanced systems and fully integrated features:

### 🛡️ AutoLoot System
- **Fully Integrated**: Built directly into the source for maximum performance.
- **Commands**: 
  - `!autoloot` - Opens the GUI management window.
  - `!autoloot on/off` - Quickly toggle the system.
  - `!autoloot clear` - Clear your loot list.
- **Bank Integration**: Automatically deposits gold if "AutoMoney" mode is enabled.

### ⚔️ Guild War System
- **Real Guild Wars**: Fully working war system with emblems.
- **Commands**: `/war invite, guildname`, `/war accept, guildname`.
- **Emblems**: Ally, Member, and Enemy emblems update in real-time.

### ⚔️ Forge & Classification System
- Items can have **Tier** and **Classification** attributes.
- **Forge**: Tier system allows for item upgrades via fusion and strong progression.
- **Classification**: System for categorizing items by rarity or power.
- Fully integrated with Lua scripting API for custom RPG systems.

### 🏆 Reward Boss System
- **Tibia-like Rewards**: Global Tibia style boss reward system.
- **Contribution Tracking**: Tracks damage done, damage taken, and healing done.
- **Fair Distribution**: Distributes loot based on contribution score.
- **Reward Chests**: Rewards are stored in reward containers (ID: 21518/21584).
- Configurable reward rates via config manager.

### 💤 Offline Training System
- Train skills while offline using beds (Premium required).
- **Skills**: Sword, Axe, Club, Distance, Shielding, and Magic Level.
- **Usage**: simply click on the bed to start training.
- Automatically calculates gain based on logout duration (Max 12h).
- **Configuration**: efficiency and vocation rates configurable in config.lua.

### 🏰 Guild Halls System
- **Guild Leaders** can purchase special Guild Halls.
- Paid via Guild Bank balance.
- **Features**: Supports all house features (doors, beds, protection).
- **Commands**:
  - `!buyhouse` - Purchase a guild hall (Leader/Vice-Leader).
  - `!leavehouse` - Abandon the hall.

### 🛡️ House Protection System
- **Per-house control**: Owners can toggle protection state.
- **Secure**: When enabled, ONLY owner and guests can move items.
- **Commands**:
  - `!protecthouse on/off` - Toggle protection.
  - `!houseguest add/remove/list` - Manage safe list.
- Door messages show real ownership info.

### ⚡ Improved Decay System
- Enhanced decay system for better server performance.
- Optimized item decay processing and state management.

### 📺 Live Cast System
- Stream your gameplay (`!cast`) for others to watch.
- **Bonus**: Configurable EXP bonus for active casters.
- **Spectators**: Can chat in the Live Cast channel.
- **Commands**: `/spectators`, `/kick`, `/mute`, `/ban` (for broadcasters).

### 🔥 Forge System (Item Fusion)
- **Tier Upgrading**: Fuse two identical items — one is consumed, the other gains +1 tier.
- **Tier Range**: 0 → 9, capped by item classification.
- **Success Rates**: 50% (T0) down to 5% (T9), with scaling gold and dust costs.
- **Materials**: Forge Dust, Silver Tokens, and Exalted Cores (required from T5+).
- **On Success**: Upgraded item is placed inside an Exaltation Chest and delivered to the player's inventory.
- **Commands**: `/forge info`, `/forge dust`, `/forge silver`.

### 🧿 Imbuement System
- **Two Methods**: Apply directly via **Imbuement Scrolls** or craft from **raw materials** using an Etcher tool.
- **Workbench**: 4-slot station — 1 equipment + up to 3 scrolls or materials.
- **27 Imbuement Types**: Skill boosts, Magic Level, Life/Mana Leech, Critical Hit, Elemental Damage & Protection, Speed, Capacity, and more.
- **3 Tiers**: Flawed → Intricate → Powerful, with increasing costs and power.
- **Owner Lock**: Only the item's owner can imbue it.

### 🏰 Instance System
- **Isolated Areas**: Create private dungeon instances — monsters, effects, and items are only visible to players in the same instance.
- **Lua API**: `player:setInstanceId()`, `Game.registerInstanceArea()`, `Game.createMonster()` with instance parameter.
- **C++ Core**: Spectator filtering, item visibility, and interaction checks all respect instance boundaries.
- **Use Case**: Solo/party dungeons, boss rooms, quests — without interfering with the main world.

### 🧘 Harmony System (Monk Vocation)
- **Exclusive to Monks** (vocations 9-10): gain Harmony points by hitting enemies.
- **Virtues**: Rotating states — Justice, Harmony, Sustain — each with unique bonuses.
- **Scaling Bonuses**: XP and damage increase with accumulated Harmony.
- **Command**: `!harmony`.

---

## 🛠️ Compilation

### 🐧 Ubuntu 22.04 / 24.04

> [!IMPORTANT]
> This project requires Boost 1.75+ and Lua 5.4.
> - **Ubuntu 24.04**: Recommended (comes with required versions).
> - **Ubuntu 22.04**: You may need to manually update Boost, as the default version is 1.74.

#### 1. Install dependencies

```bash
sudo apt install git cmake build-essential liblua5.4-dev libmysqlclient-dev libboost-system-dev libboost-iostreams-dev libboost-filesystem-dev libboost-locale-dev libboost-regex-dev libpugixml-dev libfmt-dev libssl-dev libspdlog-dev libmimalloc-dev -y
```

#### 2. Install mimalloc (optional but recommended)

```bash
sudo apt install libmimalloc-dev -y
```

> **Note:** Without `libmimalloc-dev`, cmake may print `Could NOT find mimalloc (missing: mimalloc_DIR)` followed by `mimalloc found at /usr/.../libmimalloc.so`. This is expected — the first line means the cmake package config was not found, but the second line confirms the library was located via fallback and **will be linked correctly**. Installing `libmimalloc-dev` eliminates the double message.

#### 3. Clone and compile

```bash
git clone -b Revscrypt-full --single-branch https://github.com/Mateuzkl/forgottenserver-downgrade-1.8-8.60.git
cd forgottenserver-downgrade-1.8-8.60
mkdir build && cd build
cmake ..
make -j$(nproc)
```

#### ⚡ Optimized Release Build (Recommended for Production)

For maximum performance on Linux (especially for high-load servers), use these cmake flags:

```bash
mkdir -p build-release && cd build-release
cmake -DCMAKE_BUILD_TYPE=Release \
      -DDISABLE_STATS=1 \
      -DENABLE_SLOW_TASK_DETECTION=OFF \
      -DUSE_MIMALLOC=ON \
      ..
cmake --build . -- -j$(nproc)
```

| Flag | Description |
|------|-------------|
| `-DCMAKE_BUILD_TYPE=Release` | Enables `-O3 -march=native -flto` optimizations |
| `-DDISABLE_STATS=1` | Removes runtime stats overhead |
| `-DENABLE_SLOW_TASK_DETECTION=OFF` | Removes per-task timing overhead |
| `-DUSE_MIMALLOC=ON` | Uses Microsoft's mimalloc allocator (faster than glibc malloc) |

**Alternative (mimalloc without recompiling):**
```bash
LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libmimalloc.so ./tfs
```

#### 🔧 Linux Server Tuning

```bash
# Set CPU governor to performance mode
sudo cpupower frequency-set -g performance

# Run with higher priority
sudo nice -n -10 ./tfs
```

### 🪟 Windows

Recommended usage with **vcpkg**. See [Wiki Guide](https://github.com/MillhioreBT/forgottenserver-downgrade/wiki/Compiling-on-Windows-(vcpkg)).

---

## � Website (MyAAC) — SHA256 Password Support

> [!IMPORTANT]
> This TFS 1.8 uses **SHA256 + salt** for password hashing instead of the traditional SHA1. The standard MyAAC will **not work** for creating accounts or logging in.

You **must** use the modified MyAAC fork that supports SHA256:

**Repository:** [https://github.com/Mateuzkl/myaac](https://github.com/Mateuzkl/myaac)

```bash
git clone https://github.com/Mateuzkl/myaac.git
```

### What was changed?

- Account creation hashes passwords using `SHA256 + random salt` in the format: `$SHA256$<salt>$<hash>`
- Login verification supports both **new SHA256** and **legacy SHA1** formats
- **Transparent migration**: when a player logs in with an old SHA1 password, the server automatically upgrades it to SHA256+salt in the database

### Why?

SHA1 is considered **insecure** and deprecated for password storage. SHA256 with per-account random salt provides significantly better security against rainbow table and brute-force attacks.

> If you use a different AAC (Znote, Gesior, etc.), you will need to adapt the password hashing functions to use the `$SHA256$<salt>$<hash>` format described above.

---

## 📦 Client Configuration (OTCv8 and Mehah)

To fully utilize features like extended sprites and mounts, updates are required:

**1. Update `modules/game_features/game_features.lua`:**

```lua
if(version >= 860) then
    g_game.enableFeature(GameAttackSeq)
    g_game.enableFeature(GameBot)
    g_game.enableFeature(GameExtendedOpcode)       
    g_game.enableFeature(GameSkillsBase)
    g_game.enableFeature(GamePlayerMounts)
    g_game.enableFeature(GameMagicEffectU16)
    g_game.enableFeature(GameDistanceEffectU16)
    g_game.enableFeature(GameDoubleHealth)
    g_game.enableFeature(GameOfflineTrainingTime)
    g_game.enableFeature(GameDoubleSkills)
    g_game.enableFeature(GameBaseSkillU16)
    g_game.enableFeature(GameAdditionalSkills)
    g_game.enableFeature(GameIdleAnimations)
    g_game.enableFeature(GameEnhancedAnimations)
    g_game.enableFeature(GameSpritesU32)
    g_game.enableFeature(GameExtendedClientPing)
    g_game.enableFeature(GameDoublePlayerGoodsMoney)
end
```

**2. Extended Sprites (GameSpritesU32)**
- Download the sprites: [Octv8--Classic-8.6](https://github.com/Mateuzkl/Octv8--Classic-8.6)
- Extract `.spr` and `.dat` to your OTCv8 directory.

> **Client With DLL (Mounts)**: [Download Client 8.60 + DLL](https://github.com/Mateuzkl/Client-cip-8.60-with-DLL-Mount).*

---

## 🎮 Extended Options for Modified 8.60 CIP Clients

This server supports extended protocol features for **modified 8.60 CIP clients** using DLL patches. These features allow the old Tibia client to handle values beyond the original protocol limitations:

| Feature | Status | Description |
|---------|--------|-------------|
| `__MAGIC_EFFECTS_U16__` | ✅ OK | Supports magic effects up to 65535 (uint16) instead of 255 |
| `__DISTANCE_SHOOT_U16__` | ✅ OK | Supports distance/projectile effects up to 65535 (uint16) instead of 255 |
| `__PLAYER_HEALTH_U32__` | ✅ OK | Supports player health values up to 4.2 billion (uint32) instead of 65535 |
| `__PLAYER_MANA_U32__` | ✅ OK | Supports player mana values up to 4.2 billion (uint32) instead of 65535 |
| `__PLAYER_SKILLS_U16__` | ⏳ Pending | Skill levels up to 65535 (requires implementation) |
| **Outfit Limit Changer** | ✅ OK | Allows more than 255 outfits (uses uint16 for outfit count) |
---

## 🧠 Memory Safety & Smart Pointer Roadmap

A full ownership and RAII audit of all **132 source files** was completed. The goal is progressive, safe migration toward modern C++ lifetime management without breaking the server.

### ✅ Fixes Already Applied (Valgrind: 0 leaks, 0 errors)

| File | Fix |
|------|-----|
| `container.h / container.cpp` | Removed erroneous `incrementReferenceCounter` / `decrementReferenceCounter` calls from `addThing`, `removeThing`, `replaceThing` — aligned with upstream TFS. Eliminated 176-byte leak and latent UAF. |
| `house.cpp` | Added `House::~House()` to properly decrement refcount of doors in `doorSet`. Previously doors were never freed (58,351 bytes). |
| `depotlocker.cpp / depotchest.cpp` | `DepotChest` started with `referenceCounter=0`; destructor returned early without freeing. Fixed by calling `incrementReferenceCounter()` at construction. (4,152 bytes). |
| `creature.h / creature.cpp` | `setRemoved()` now clears `attackedCreature` / `followCreature`. `onThink()` and `onAttacking()` check `isRemoved()` before interacting with targets. Debug assert on over-decrement. |
| `monster.cpp` | Removed dead `onIdleStatus()` call in `death()` — guard `!isDead()` made it a no-op. |
| `iologindata.cpp` | Removed conditional `decrementReferenceCounter` compensations in `transferLoadedItem` / `transferLoadedItemAt` lambdas (aligned with Container fix). |

### 🗺️ Future Roadmap (Prioritized)

| Priority | Files |
|----------|-------|
| **High** | `item.*`, `game.*`, `creature.*`, `iologindata.*`, `container.*`, `player.*`, `monster.*`, `tile.*`, `map.*` |
| **Medium** | `chat.*`, `house.*`, `iomapserialize.*`, `iomap.*`, `luacreature.cpp`, `luagame.cpp`, `decay.*`, `events.*`, `spawn.*`, `protocolgame.*`, `party.*` |
| **Low / Polish** | `combat.*`, `configmanager.*`, `guild.*`, `housetile.*`, Lua layer files |

> A complete interactive audit report is available in `tfs-smart-pointer-review-completo.html` at the repository root.

### 📅 Fix Release Schedule

Memory safety and robustness improvements are shipped as **monthly fix releases** (e.g. `fix1`, `fix2`, …). Each release targets specific high-priority files from the roadmap above, verified with Valgrind before publishing. Check the [Releases](https://github.com/Mateuzkl/forgottenserver-downgrade-1.8-8.60/releases) page for the latest.

---

## 🐛 Contributing & Issues

The base is stable and the systems are fully working. If you find a bug — whether a memory issue, logic error, or any unexpected behavior — **you are very welcome to help**:

- **Open an Issue** on [GitHub Issues](https://github.com/Mateuzkl/forgottenserver-downgrade-1.8-8.60/issues) with a clear description, steps to reproduce, and any relevant logs or Valgrind output.
- **Submit a Pull Request** if you already have a fix. Surgical/minimal patches are preferred — change only what is necessary.

Any contribution is appreciated. This server is optimized, actively maintained, and packed with exclusive systems — community involvement helps keep it that way.

_Maintained by [Mateuzkl](https://github.com/Mateuzkl)._

---

## 📢 Project Status

This project is nearly at **800 commits** and the base is fully stable, feature-rich, and ready to use.

The focus going forward is on **progressive memory safety** — applying the smart pointer roadmap in monthly fix releases while keeping all existing exclusive systems working.

If you enjoy using this server, find it useful, or benefit from the work put into it, any support is deeply appreciated.

### 🤝 Support the Project

Donations help keep the project alive, fund continued development, and motivate new system releases.

**PIX Key (Random) for Donations:**

`f8761afe-5581-417d-afc8-08cac410a1b0`

Thank you to everyone who contributes — whether through code, bug reports, or donations.

---

## 📥 How to Download the Latest Client (Executable & DLLs) / Client Updater

If you need the ready-to-use **executable** and **DLLs**, follow these simple steps:

1.  **Click this link**: [Project on AppVeyor](https://ci.appveyor.com/project/Mateuzkl/forgottenserver-downgrade-1-7-8-60)
2.  Look for the **"Artifacts"** tab (or click on the latest Job specific to your platform, often named `Environment: ...` or `Configuration: ...`, then find the "Artifacts" tab there).
    *   *Note: If you are on the main project page, you might need to click on the latest "Job" listed under "Job name" first.*
3.  **Download** the files listed there (usually a `.zip` or `.7z` file containing the executable and DLLs).
4.  **Extract** the downloaded files into your client folder, replacing existing ones if necessary.

---

## 🔄 Client Updater (Automated)

To easily update your client files (CipSoft client, executables, DLLs), follow our simple tutorial: 

*   **[Click here for the Client Updater Tutorial](https://github.com/Mateuzkl/Client_Mout_Updater)**

This guide explains how to automatically update everything with just a few clicks.


