#!/usr/bin/env bash
#
# install.sh — chemind one-command installer
# Usage: bash install.sh
#
set -euo pipefail

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "========================================"
echo " chemind v0.3.0 Installer"
echo "========================================"
echo ""

# 1. Install the skill
echo -e "${YELLOW}[1/5]${NC} Installing chemind skill..."
npx skills install github:uranus421-glitch/chemind
echo -e "${GREEN}✓${NC} chemind installed"
echo ""

# 2. Install academic-search dependency (CDP infrastructure)
echo -e "${YELLOW}[2/5]${NC} Installing academic-search dependency..."
npx skills install github:uranus421-glitch/academic-search
echo -e "${GREEN}✓${NC} academic-search installed"
echo ""

# 3. Install Python dependencies
echo -e "${YELLOW}[3/5]${NC} Installing Python dependencies..."
if command -v python3 &>/dev/null; then
    python3 -m pip install PyMuPDF 2>/dev/null && echo -e "${GREEN}✓${NC} PyMuPDF installed" || echo -e "${YELLOW}⚠${NC} PyMuPDF install failed"
    python3 -m pip install akshare 2>/dev/null && echo -e "${GREEN}✓${NC} akshare installed (A-share financial data)" || echo -e "${YELLOW}⚠${NC} akshare install failed"
    python3 -m pip install secedgar 2>/dev/null && echo -e "${GREEN}✓${NC} secedgar installed (SEC EDGAR filings)" || echo -e "${YELLOW}⚠${NC} secedgar install failed"
    python3 -m pip install defuddle 2>/dev/null && echo -e "${GREEN}✓${NC} defuddle installed (article scraper)" || echo -e "${YELLOW}⚠${NC} defuddle install failed"
    python3 -m pip install requests 2>/dev/null && echo -e "${GREEN}✓${NC} requests installed" || echo -e "${YELLOW}⚠${NC} requests install failed"
else
    echo -e "${RED}✗${NC} python3 not found — install Python 3 first"
fi
echo ""

# 4. Install Node.js dependencies (defuddle global)
echo -e "${YELLOW}[4/5]${NC} Installing Node.js dependencies..."
if command -v npm &>/dev/null; then
    npm install -g defuddle 2>/dev/null && echo -e "${GREEN}✓${NC} defuddle (npm) installed" || echo -e "${YELLOW}⚠${NC} defuddle npm install failed — run: npm install -g defuddle"
else
    echo -e "${YELLOW}⚠${NC} npm not found — skip defuddle npm install"
fi
echo ""

# 5. Run environment check
echo -e "${YELLOW}[5/5]${NC} Running environment check..."
SCRIPTS_DIR="$HOME/.claude/skills/chemind/scripts"
if [ -f "$SCRIPTS_DIR/check-env.sh" ]; then
    bash "$SCRIPTS_DIR/check-env.sh"
else
    echo -e "${YELLOW}⚠${NC} check-env.sh not found at $SCRIPTS_DIR"
fi

echo ""
echo "========================================"
echo -e "${GREEN} chemind v0.3.0 installation complete!${NC}"
echo ""
echo "Quick test: ask Claude '化工产业研究' or"
echo "'search OpenAlex for bio-based polyamide' or"
echo "'A股年报 万华化学 投资分析'"
echo "========================================"
