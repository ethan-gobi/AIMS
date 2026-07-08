# AIMS

**An AI coding agent that lives in your terminal.** Tell it what you want in plain
English — *"fix the failing tests"*, *"add a login page"* — and AIMS reads your code,
makes the changes, and runs the commands to get it done. From intent to production.

---

## Install

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
[Releases page](https://github.com/ethan-gobi/AIMS/releases/latest) and run it.
If SmartScreen warns: **More info → Run anyway**.

---

## Update

```
AIMS update
```

Updates in place from the latest release.

---

## How it works

1. **Pick a model.** AIMS connects to the AI you choose — Claude, GPT, or local
   models via Ollama, plus many more. Type `/connect` to add a provider.
2. **Describe the task.** Ask in plain English at the prompt.
3. **AIMS does the work.** It reads your files, edits code, runs tests and shell
   commands, and shows you every change before it lands.

---

## Name & commercial use

The **"AIMS" name, brand, and logo are © 2026 Ethan Gobi.** You may not sell,
distribute, or publish this software under the "AIMS" name or branding without written
permission.

For commercial use, business licensing, or managed hosting, contact
**proffesethgob@gmail.com**.
