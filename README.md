## GFW Anti-DPI(AntiSpy) Fingerprint UA Randomizer 🛡️

<div align="center">


**One-click PowerShell patcher to eliminate Go-http-client static UA fingerprints from VPN/Proxy executables.**

</div>

***

## 🎯 The Problem

GFW and DPI systems detect these **hardcoded signatures** in requests sent by proxy cores:

```
Go-http-client/1.1
Go-http-client/2.0
```

These static strings act as a **critical fingerprint** that allows deep packet inspection systems to identify and block proxy traffic — even when TLS encryption is active.

***

## ✅ The Solution

Binary-level patching replaces the static UA with a **random length&character alphanumeric string** on every run.

| Before (Detected 🚫) | After (Safe ✅) |
|----------------------|----------------|
| `Go-http-client/1.1` | `XyHiJkLs` |
| `Go-http-client/2.0` | `XyHiJkLs` |

> **Byte-perfect replacement** — exact 18 bytes each = zero crash risk

***

## 🚀 Usage — 3 Steps Only

```
Step 1 — Copy patcher.cmd into your EXE folder
Step 2 — Right-click patcher.cmd → "Run as administrator"
Step 3 — Select EXE number and press Enter
```

### 📁 Folder Structure

```
VPN-Folder/
├── 📄 sing-box.exe              ← Vulnerable (before)
├── 📄 xray.exe                  ← Vulnerable (before)
├── 📄 mihomo.exe                ← Vulnerable (before)
├── 📄 ...                       ← Other targets
├── ⚙️  patcher.cmd               ← Drop here & run
    ↓ ↓ ↓
├── ✅ sing-box-patched.exe       ← Safe (after)
├── ✅ xray-patched.exe           ← Safe (after)
└── ✅ mihomo-patched.exe         ← Safe (after)
```

### 🔄 Replace Original (Recommended)

```
1. ⛔ STOP your VPN/proxy service
2. 💾 Backup original EXE
3. ✏️  Rename *-patched.exe → original name
4. ▶️  Restart VPN/proxy service
```

***

## 💻 Example Output

```powershell
=== GFW Anti-DPI Fingerprint UA Randomizer ===
1. FlClashCore.exe
2. mihomo.exe
3. sing-box.exe
4. xray.exe
...

Select EXE (1-9) or Q=Quit: 3

Patching sing-box.exe...

PATCH SUCCESS!
File : sing-box-patched.exe
New UA : XyZaBcDeFgHiJkLmNoPqRsTuVw9876543210

Press Enter to continue...
```

***

## 🎯 Supported & Tested Binaries

| # | Binary | Client App | Support | Notes |
|---|--------|-----------|:-------:|-------|
| 1 | `FlClashCore.exe` | FlClash | ✅ Full | Mihomo-based core |
| 2 | `verge-mihomo.exe` | Clash Verge Rev | ✅ Full | Mihomo fork |
| 3 | `nekobox_core.exe` | NekoBox | ✅ Full | sing-box based |
| 4 | `Core.exe` | Various | ✅ Full | Generic Go core |
| 5 | `mihomo.exe` | Clash Meta / Mihomo | ✅ Full | Official Mihomo |
| 6 | `sing-box.exe` | Hiddify / SFM / SFA | ✅ Full | All versions |
| 7 | `xray.exe` | v2rayN / Nekoray | ✅ Full | Core + clients |
| 8 | `v2raya.exe` | V2RayA | ✅ Full | Web UI core |
| 9 | `ThroneCore.exe` | Throne | ✅ Full | Go-based core |

***

## 🛡️ Security & Safety

```
✅ Exact byte-length replacement  →  No crashes, no corruption
✅ No code injection              →  Clean binary modification
✅ No external dependencies       →  Pure PowerShell
✅ Random UA every run            →  No pattern repetition
✅ Visual offset reporting        →  Full transparency
✅ Original file untouched        →  Auto-saves as *-patched.exe
```

***

## ⚙️ Features

- 🔄 **Batch patching** — list and patch multiple EXEs in one session
- 🎲 **Random UA generator** — 36-char alphanumeric (A-Z, a-z, 0-9)
- 🔍 **Pattern scanner** — detects all occurrences of both patterns
- 💾 **Auto-naming** — saves as `original-patched.exe`
- 🎨 **Clean UI** — colored output + window title
- ♾️ **Loop mode** — patch multiple files without restart

***

## 📋 FAQ

**Q: Will it break my EXE?**
> No. Exact byte-length replacement preserves binary structure completely.

**Q: Antivirus flags it?**
> Possibly (false positive). Binary patching triggers heuristic AV detection. Add exception or run in isolated folder.

**Q: Does it work on Linux/macOS?**
> Use the Python version or compile the core from source with custom UA.

**Q: How often should I re-patch?**
> After every core update — new versions restore original UA.

**Q: Can I add custom hex patterns?**
> Yes. Edit `$pattern1`, `$pattern2` byte arrays at top of script.

***

## 🔧 Advanced Customization

```powershell
# Change random UA length
Get-Random -Count 36   →   Get-Random -Count 24

# Add custom hex pattern
$pattern3 = [byte[]] (0x47,0x6f,0x2d,...)

# Use fixed UA instead of random
$randomUA = "CustomUA-MyBuild-v1.0-Release"
```

***

## 📌 Why Not Just Recompile?

| Method | Difficulty | Time | Risk |
|--------|-----------|------|------|
| Recompile from source | 🔴 Hard | Hours | High |
| Binary patch (this tool) | 🟢 Easy | Seconds | Zero |
| UI config override | 🔴 Impossible | — | — |

> UI tools cannot override hardcoded Go HTTP library UA strings — **binary patching is the only client-side fix**.

***

## 📄 License

```
MIT License — Free for all uses
Personal, commercial, research, circumvention
```

***

## 🙌 Support

⭐ **Star** this repo if it helped you
🐛 **Open an issue** for bugs or suggestions
🔀 **Pull requests** are welcome

***

<div align="center">

**Built for the privacy & circumvention community worldwide** 🌍

</div>

