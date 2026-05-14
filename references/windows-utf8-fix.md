# Windows UTF-8 Environment Fix

> Permanent fix for Chinese text encoding issues on Windows terminals.

## Root Cause

Windows terminal (cmd/PowerShell/Git Bash) defaults to **GBK (CP936)** encoding. Python's `print()` and shell pipes use this codepage, causing `UnicodeEncodeError` on any Chinese character outside GBK's range.

## Solution 1: Python Environment Variables (Recommended)

Add to `~/.bashrc` or `~/.zshrc`:

```bash
export PYTHONIOENCODING=utf-8
export PYTHONUTF8=1
```

Or in PowerShell profile:

```powershell
$env:PYTHONIOENCODING = "utf-8"
$env:PYTHONUTF8 = "1"
```

## Solution 2: Python In-Code Fix

```python
import sys
sys.stdout.reconfigure(encoding='utf-8')
```

## Solution 3: Git Bash / MSYS2 Terminal

```bash
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
```

## Solution 4: Windows Codepage

```bash
chcp 65001   # Temporary switch to UTF-8
```

Permanent via registry:
```
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage\OEMCP = 65001
```

## The Golden Rule: Write to File, Don't Print

The most reliable approach — especially for PDF text extraction or multi-kilobyte Chinese output:

```python
# ❌ WRONG — will crash on Chinese characters
print(f"Result: {chinese_text}")

# ✅ CORRECT — always write to UTF-8 file, then read with Read tool
with open('/tmp/output.txt', 'w', encoding='utf-8') as f:
    f.write(f"Result: {chinese_text}")
```

## PowerShell 7+ Required

PowerShell 5.1 (`powershell.exe`) has a known UTF-8 parsing bug: Chinese text containing `[建议]` or similar `[Chinese]` patterns is mis-parsed as array index operators.

**Always use `pwsh` (PowerShell 7+)**, never `powershell` (PS 5.1).

## Quick Fix for Claude Code Sessions

Prefix every Python command with the env var:

```bash
PYTHONIOENCODING=utf-8 python3 -c "..."
```

Or set once at session start:

```bash
echo 'export PYTHONIOENCODING=utf-8' >> ~/.bashrc
source ~/.bashrc
```

---

*Last validated: 2026-05-14 | Windows 11 | Git Bash + MSYS2*
