# TooManyJouko

<p align="center">
  <img src="https://raw.githubusercontent.com/Rafanov/ToManyJouko/main/chara.png" alt="TooManyJouko" width="120" style="border-radius: 16px"/>
</p>

<p align="center">
  <b>A Windows GUI experiment that simulates exponential window spawning behavior, built with Python and Tkinter.</b>
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Python-3.x-blue?logo=python" />
  <img src="https://img.shields.io/badge/Tkinter-GUI-lightgrey?logo=python" />
  <img src="https://img.shields.io/badge/Pillow-Image-green" />
  <img src="https://img.shields.io/badge/Platform-Windows-0078D6?logo=windows" />
</p>

---

## 📖 Overview

**jouko** is a lightweight desktop simulation built as a personal experiment in GUI event handling, process behavior, and resource usage patterns on Windows.

The program spawns a styled window containing a static image and an input field. When the user closes a window, the application doubles the number of active windows — creating an exponential growth pattern. The simulation ends when the user enters the correct keyword.

> ⚠️ **This is a simulation / learning experiment.** It is not intended for production use, pranks, or deployment on devices without the owner's consent.

---

## 🎯 Purpose

This project was built to explore and learn:

- How GUI frameworks handle multiple concurrent windows
- Event-driven programming patterns in Tkinter
- Resource behavior under exponential load (CPU / RAM / render pipeline)
- PyInstaller packaging and Windows `.exe` distribution
- PowerShell-based one-liner deployment scripts (`iex | irm`)

---

## ⚙️ How It Works

1. The app launches with **1 window** displaying a character image and a text input field
2. When the user closes a window (clicks ✕), the app **doubles** the total window count:
   - 1 → 2 → 4 → 8 → 16 → ...
3. New windows are spawned at **randomized screen positions** to fill the display
4. Spawning uses burst-based `after()` scheduling to keep the UI responsive
5. The image asset is **loaded once** and shared across all windows for performance
6. Entering the keyword `Jouko` and pressing **Enter** instantly closes all windows

```
Close 1 window (n active) → spawn n × 2 new windows
Type "Jouko" + Enter       → destroy all windows immediately
```

---

## ⚠️ Warning

| Risk | Detail |
|---|---|
| 🧠 RAM usage | Each window allocates GUI resources; scales exponentially |
| 🔥 CPU load | Rendering dozens of windows simultaneously is intensive |
| 🖥️ Display disruption | Windows will cover the entire screen at higher counts |
| ❌ Not for primary devices | Run in a VM or isolated test environment |

**Do not run this on a machine where interruption would cause data loss.**

---

## 🛑 How to Stop

**Method 1 — Keyword (recommended)**
Type `Jouko` (case-sensitive) in any input field and press **Enter**.
All windows will close instantly.

**Method 2 — Task Manager**
1. Press `Ctrl + Shift + Esc`
2. Find `python.exe` or `jouko.exe`
3. Click **End Task**

**Method 3 — PowerShell**
```powershell
Stop-Process -Name "python" -Force
# or if compiled:
Stop-Process -Name "jouko" -Force
```

---

## 🔐 Security & Ethical Disclaimer

- ✅ No network requests — fully offline
- ✅ No data collection of any kind
- ✅ No system modifications or registry changes
- ✅ No exploitation of OS vulnerabilities
- ✅ Source code is fully transparent and readable
- ✅ Built purely for GUI behavior research and personal learning

This project does **not** contain malicious code of any kind.

---

## 🚫 Usage Restrictions

- Do **not** run on another person's device without their explicit consent
- Do **not** use as a prank tool or to disrupt workflows
- Do **not** deploy in any shared, production, or work environment
- Use responsibly — this is a learning tool, not a weapon

---

## 🧠 Learning Value

| Topic | What This Project Demonstrates |
|---|---|
| Event handling | `WM_DELETE_WINDOW` protocol, `<Return>` key binding |
| Window management | `Toplevel` lifecycle, shared root in Tkinter |
| Performance optimization | Single image load + shared `PhotoImage` reference across N windows |
| Spawning strategy | Burst-based `after()` scheduling to prevent UI freeze |
| Exponential growth | Practical demonstration of `O(2^n)` resource consumption |
| Packaging | PyInstaller `--onefile` bundling with embedded assets |
| Distribution | PowerShell one-liner install via `iex (irm ...)` |

---

## 🛠️ Tech Stack

| Technology | Role |
|---|---|
| **Python 3.x** | Core language |
| **Tkinter** | GUI framework (built-in) |
| **Pillow (PIL)** | Image loading and resizing |
| **PyInstaller** | Compile to standalone `.exe` |
| **PowerShell** | One-liner install script |

---

## 🚀 How to Run

**Requirements**
- Python 3.8+
- `pip install pillow`

**From source**
```bash
# Clone the repo
https://github.com/Rafanov/ToManyJouko.git
cd jouko

# Install dependency
pip install pillow

# Run
python main.py
```

**One-liner install (Windows PowerShell)**
```powershell
iex (irm "https://raw.githubusercontent.com/Rafanov/ToManyJouko/main/install.ps1")
```
> If you get a script execution error, run this first:
> ```powershell
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
> ```

**Build to `.exe` yourself**
```bash
pip install pyinstaller
pyinstaller --onefile --windowed --add-data "chara.png;." --add-data "icon.ico;." --icon "icon.ico" --name "jouko" main.py
# Output: dist/jouko.exe
```

---

## 📝 Notes

- No pre-built `.exe` is distributed in this repository — build it yourself from source
- Run in a **VM or isolated environment** for safety
- The keyword is case-sensitive: `Jouko` (capital J)
- Tested on Windows 10 / 11

---

## 📄 License

MIT License — free to use, modify, and learn from.

---

<p align="center">Built for curiosity. Run responsibly.</p>
