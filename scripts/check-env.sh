#!/usr/bin/env bash
#
# check-env.sh — Environment check for deep-lit skill
# Verifies: Python3, Node.js, Chrome debug port, CDP proxy
#
# Usage: bash check-env.sh
# Also sources the academic-search check-deps.sh for CDP infrastructure.

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================"
echo " deep-lit Environment Check"
echo "========================================"

FAILURES=0

# --- Python 3 ---
if command -v python3 &>/dev/null; then
    PY_VER=$(python3 --version 2>&1)
    echo -e "${GREEN}✓${NC} Python3: $PY_VER"
else
    echo -e "${RED}✗${NC} Python3: not found"
    FAILURES=$((FAILURES + 1))
fi

# --- Python dependencies ---
if command -v python3 &>/dev/null; then
    if python3 -c "import fitz" 2>/dev/null; then
        echo -e "${GREEN}✓${NC} PyMuPDF (fitz): installed"
    else
        echo -e "${YELLOW}⚠${NC} PyMuPDF (fitz): not installed — run: pip install PyMuPDF"
    fi
fi

# --- Node.js ---
if command -v node &>/dev/null; then
    NODE_VER=$(node --version 2>&1)
    echo -e "${GREEN}✓${NC} Node.js: $NODE_VER"
else
    echo -e "${RED}✗${NC} Node.js: not found"
    FAILURES=$((FAILURES + 1))
fi

# --- npx ---
if command -v npx &>/dev/null; then
    echo -e "${GREEN}✓${NC} npx: available"
else
    echo -e "${YELLOW}⚠${NC} npx: not found"
fi

# --- PowerShell 7+ ---
if command -v pwsh &>/dev/null; then
    PS_VER=$(pwsh -NoProfile -Command '$PSVersionTable.PSVersion.ToString()' 2>&1)
    echo -e "${GREEN}✓${NC} PowerShell 7+: v$PS_VER"
else
    echo -e "${RED}✗${NC} PowerShell 7+: not found (PS 5.1 has UTF-8 bugs — install PS7)"
    FAILURES=$((FAILURES + 1))
fi

# --- Windows-specific ---
case "$(uname -s)" in
    MINGW*|MSYS*|CYGWIN*)
        echo -e "${GREEN}✓${NC} Shell: Git Bash / MSYS2 (compatible)"
        ;;
    Linux)
        echo -e "${GREEN}✓${NC} Shell: Linux (compatible)"
        ;;
    Darwin)
        echo -e "${GREEN}✓${NC} Shell: macOS (compatible)"
        ;;
    *)
        echo -e "${YELLOW}⚠${NC} Shell: unknown — assuming compatible"
        ;;
esac

# --- CDP Chrome check (from academic-search) ---
ACADEMIC_SEARCH_DIR="$HOME/.claude/skills/academic-search"
echo ""
echo "--- CDP Infrastructure (academic-search) ---"

if [ -d "$ACADEMIC_SEARCH_DIR" ]; then
    echo -e "${GREEN}✓${NC} academic-search: installed at $ACADEMIC_SEARCH_DIR"

    if [ -f "$ACADEMIC_SEARCH_DIR/scripts/check-deps.sh" ]; then
        echo ""
        echo "Running academic-search CDP dependency check..."
        bash "$ACADEMIC_SEARCH_DIR/scripts/check-deps.sh"
    else
        echo -e "${YELLOW}⚠${NC} academic-search/scripts/check-deps.sh not found — CDP not verified"
    fi
else
    echo -e "${RED}✗${NC} academic-search: NOT installed"
    echo "  Install with: npx skills install github:uranus421/academic-search"
    echo "  (or the correct academic-search repo URL)"
    FAILURES=$((FAILURES + 1))
fi

echo ""
echo "========================================"
if [ $FAILURES -eq 0 ]; then
    echo -e "${GREEN}All critical checks passed. deep-lit is ready.${NC}"
else
    echo -e "${RED}${FAILURES} critical failure(s) found.${NC}"
    echo "Please fix the above issues before using deep-lit."
fi
echo "========================================"
