# 🖥️ WezTerm Configuration

A clean and fully-customizable WezTerm setup designed for Windows & Linux, with:

- 🔄 Persistent color-scheme switching
- 🎨 Fetch and sorts a list of color themes from the builtin selection
- 🖼 Optional wallpaper support
- 💻 Custom fastfetch system summary
- 🧩 Cross-platform-safe paths
- 🖱 Quality-of-life mouse and keybinding tweaks
- 🪟 PowerShell-aware statusline on Windows
- 🔠 Nerd Font support

Perfect for anyone wanting a consistent, polished terminal experience.

---

## 🧩 Folder Structure

```text
wezterm/
├── wezterm.lua                     # Main configuration
├── color_schemes.lua              # List of available themes
├── background/
│   └── PICTURE_NAMED_background.png.txt   # Replace with your own wallpaper
├── fonts/
│   └── JetBrainsMonoNerdFontMono-Regular.ttf
└── fastfetchConfig/
    └── config.jsonc               # Optional fastfetch setup
```

---

## ✨ Features

### 🎨 Theme Switching

Press **CTRL + SHIFT + S** to cycle through all themes listed in `color_schemes.lua`.

Your current theme is automatically saved to:

```
~/.config/wezterm/.wezterm-current-scheme
```

…and restored at startup.

### 📌 Custom Themes Folder

This configuration supports additional color themes stored inside a `color/` folder,
if you'd like to pick a more pesonal selection or create you own.
You'll need to make adjustments from the default, sourcing hosted ones however.

To add your own themes:

1. Create a directory named `color` in the config root
2. Place any theme files inside it (example: `color/tokyodak.lua`)
3. Reference them from `color_schemes.lua` using:

```lua
local tokyodak = require("color.tokyodak")
```

**Included:**

- Tokyodak (custom)
- Dracula
- Nightfox / Duskfox
- Catppuccin Mocha
- OneDark
- Tokyo Night Storm
- Nord
- Gruvbox Dark
- …and many more.

---

### 🪟 Custom Background + Transparency

- Optional wallpaper at: `background/background.png`
- Default opacity: `0.92`

---

### 🖱 Mouse Tweaks

Right-click pastes from the clipboard (classic Linux behavior).

---

### ⌨ Keybindings

| Keys               | Action                       |
| ------------------ | ---------------------------- |
| `CTRL + SHIFT + T` | Open new tab                 |
| `CTRL + SHIFT + Z` | Show current theme           |
| `CTRL + SHIFT + S` | Toggle color schemes         |
| `CTRL + SHIFT + R` | Reload WezTerm configuration |
| `CTRL +  Tab`      | Toggle tabs                  |

---

## 🖥️ Shell Configuration

### Windows

Uses PowerShell 7+ automatically:

```lua
default_prog = { "pwsh", "-NoLogo" }
```

### Linux / macOS

Falls back to Bash:

```lua
default_prog = { "/usr/bin/env", "bash" }
```

---

## 📦 Installation

### Linux / macOS

```bash
git clone https://github.com/Masterkatt3n/wezterm-config ~/.config/wezterm
```

### Windows

Place the folder here:

```
C:\Users\<you>\.config\wezterm\
```

Restart WezTerm afterward.

---

## Windows Toast Notifications & Portable WezTerm

On Windows 11, portable/unpacked WezTerm builds may lose native toast notification support if no Start Menu shortcut exists.

Symptoms may include:

- `window:toast_notification()` callbacks firing normally
- no visible toast banners
- WezTerm missing from:
  - `Settings -> Notifications`
  - Installed Apps

- no notification registration persistence

The fix is simply to create a Start Menu shortcut:

```text
%APPDATA%\Microsoft\Windows\Start Menu\Programs\WezTerm.lnk
```

pointing to:

```text
C:\Users\<user>\WezTerm\wezterm-gui.exe
```

After restarting WezTerm from the Start Menu shortcut:

- toast notifications return
- WezTerm reappears in Notification Settings
- Windows restores proper application identity handling

This allows fully portable WezTerm setups without requiring:

- Program Files installation
- MSI persistence
- installer metadata retention

---

## 📄 License

This project is licensed under the MIT License — see **LICENSE** for full details.
