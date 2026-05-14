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
echo " chemind v0.2.0 Installer"
echo "========================================"
echo ""

# 1. Install the skill
echo -e "${YELLOW}[1/4]${NC} Installing chemind skill..."
npx skills install github:uranus421-glitch/chemind
echo -e "${GREEN}✓${NC} chemind installed"
echo ""

# 2. Install academic-search dependency (CDP infrastructure)
echo -e "${YELLOW}[2/4]${NC} Installing academic-search dependency..."
npx skills install github:uranus421-glitch/academic-search
echo -e "${GREEN}✓${NC} academic-search installed"
echo ""

# 3. Install Python dependencies
echo -e "${YELLOW}[3/4]${NC} Installing Python dependencies..."
if command -v python3 &>/dev/null; then
    pip install PyMuPDF 2>/dev/null && echo -e "${GREEN}✓${NC} PyMuPDF installed" || echo -e "${YELLOW}⚠${NC} PyMuPDF install failed — run: pip install PyMuPDF"
else
    echo -e "${RED}✗${NC} python3 not found — install Python 3 first"
fi
echo ""

# 4. Run environment check
echo -e "${YELLOW}[4/4]${NC} Running environment check..."
SCRIPTS_DIR="$HOME/.claude/skills/chemind/scripts"
if [ -f "$SCRIPTS_DIR/check-env.sh" ]; then
    bash "$SCRIPTS_DIR/check-env.sh"
else
    echo -e "${YELLOW}⚠${NC} check-env.sh not found at $SCRIPTS_DIR"
fi

echo ""
echo "========================================"
echo -e "${GREEN} chemind installation complete!${NC}"
echo ""
echo "Quick test: ask Claude '化工产业研究' or"
echo "'search OpenAlex for bio-based polyamide'"
echo "========================================"
