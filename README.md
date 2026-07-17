# AIMS

**An AI coding agent.** Tell it what you want in plain English — *"fix the failing
tests"*, *"add a login page"* — and AIMS reads your code, makes the changes, and runs
the commands to get it done. From intent to production.

AIMS comes in two flavours: a **desktop app** (a clean chat window, like ChatGPT) and a
**terminal CLI**. They share the same engine — pick whichever you prefer.

---

## Desktop app (recommended)

A simple chat window. No terminal required. Code and tool steps are **hidden by
default**, so it reads like a normal conversation — flip on **Developer mode** in the
sidebar when you want to see what it actually did.

**⬇️ [Download the AIMS desktop app](https://github.com/ethan-gobi/AIMS/releases/tag/desktop-v1.0.2)**

| Your computer | File to download |
| --- | --- |
| **Mac** (Apple Silicon or Intel) | `Modern-AIMS-1.0.2-universal.dmg` |
| **Windows** | `Modern-AIMS-Windows-x64.zip` |

**Mac:** open the `.dmg` and drag **Modern AIMS** to Applications. The first launch is
blocked because the app isn't notarised yet — open **Terminal** once and run:

```
xattr -cr "/Applications/Modern AIMS.app"
```

Then open it normally from Applications.

**Windows:** unzip anywhere and run **`Modern AIMS.exe`**. If SmartScreen warns:
**More info → Run anyway**.

The app checks for updates on launch and tells you when a new version is out.

---

## Terminal CLI

### macOS (Apple Silicon **or** Intel)

**Step 1 — install AIMS.** One line (no "unidentified developer" warning):

```
curl -fsSL https://raw.githubusercontent.com/ethan-gobi/AIMS/main/install.sh | bash
```

The installer picks the right build for your chip, sets it up as `AIMS`, offers to
install **iTerm2**, and launches it for you.

**Step 2 — use iTerm2 (important).** macOS's built-in **Terminal.app renders AIMS
incorrectly** — broken colours and garbled graphics. AIMS looks right in **iTerm2**.
The installer offers to set it up automatically; to do it yourself:

```
brew install --cask iterm2
```

Then open **iTerm2** and run:

```
AIMS
```

### Windows

Download **`AIMS-windows-x64.exe`** from the
[latest release](https://github.com/ethan-gobi/AIMS/releases/latest) and run it.
If SmartScreen warns: **More info → Run anyway**.

### Update the CLI

```
AIMS update
```

Updates in place from the latest release.

---

## How it works

1. **Pick a model.** AIMS connects to the AI you choose — Claude, GPT, or local
   models via Ollama, plus many more. Use the model dropdown in the desktop app, or
   type `/connect` in the CLI to add a provider.
2. **Describe the task.** Ask in plain English.
3. **AIMS does the work.** It reads your files, edits code, runs tests and shell
   commands, and shows you every change before it lands.

Type `/` to see every command available to you.

---

## Name & commercial use

The **"AIMS" name, brand, and logo are © 2026 Ethan Gobi.** You may not sell,
distribute, or publish this software under the "AIMS" name or branding without written
permission.

For commercial use, business licensing, or managed hosting, contact
**proffesethgob@gmail.com**.
