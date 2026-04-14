# 🖥️ WezTerm Configuration

A clean and fully-customizable WezTerm setup designed for Windows & Linux, with:

- 🔄 Persistent color-scheme switching
- 🎨 Curated list of color themes (including custom Tokyodak)
- 🖼 Optional wallpaper support
- 💻 Custom fastfetch system summary
- 🧩 Cross-platform-safe paths
- 🖱 Quality-of-life mouse tweaks
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

Press **CTRL + SHIFT + T** to cycle through all themes listed in `color_schemes.lua`.

Your current theme is automatically saved to:

```
~/.config/wezterm/.wezterm-current-scheme
```

…and restored at startup.

### 📌 Custom Themes Folder

This configuration supports additional color themes stored inside a `color/` folder.

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
| `CTRL + SHIFT + T` | Toggle theme                 |
| `CTRL + SHIFT + Z` | Show current theme           |
| `CTRL + SHIFT + I` | Show config info toast       |
| `CTRL + SHIFT + R` | Reload WezTerm configuration |
| `CTRL + t`         | Open new tab                 |

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

## 📄 License

This project is licensed under the MIT License — see **LICENSE** for full details.
