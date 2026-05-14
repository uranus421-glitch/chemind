# deep-chem

> Multi-dimensional deep research Claude Code Skill for chemical, bio-based materials, polymer & life sciences industries

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

[中文](README.md) | [Deutsch](README.de.md)

---

## What It Does

`deep-chem` is the **chemical/materials & life sciences industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery.

---

## Installation

### Prerequisites

| Component | Minimum | Notes |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF for annual report extraction, data dedup |
| Node.js | 18+ | CDP browser control (core academic-search dependency) |
| PowerShell | 7+ (**not** 5.1) | PS 5.1 has UTF-8 bugs that break CJK text |
| Chrome / Chromium | Latest stable | Remote debugging mode (`chrome://inspect`) |

**Platforms**: Windows 11 ✅ | macOS ✅ | Linux ✅ (WSL2 recommended on Windows)

### One-Command Install

```bash
bash <(curl -sL https://raw.githubusercontent.com/uranus421-glitch/deep-chem/master/install.sh)
```

This handles: skill install → academic-search dependency → PyMuPDF → environment check.

### Manual Install

```bash
# 1. Install the skill
npx skills install github:uranus421-glitch/deep-chem

# 2. Install CDP infrastructure
npx skills install github:uranus421-glitch/academic-search

# 3. Install Python dependencies
pip install PyMuPDF

# 4. Verify environment
bash ~/.claude/skills/deep-chem/scripts/check-env.sh
```

### Verify

Activate by mentioning any trigger in Claude Code:

> chemical industry research · bio-based materials · polymer market · annual reports · biopharma · CDMO

---

## Dimensions Covered

| Dimension | Tools/Sources |
|------|------|
| 📚 Academic Literature | OpenAlex + Google Scholar + CNKI |
| 📄 Industrial PDFs | PyMuPDF (annual reports / patents) |
| 🏭 Market & Capacity | defuddle + WebSearch + CNKI |
| 🔬 Patents | Google Patents + CNKI patent database |
| 📏 Standards & Regulations | GB/T, ISO, EU, FDA/EMA |
| 🔗 Supply Chain | Industry reports + trade associations |
| 🤖 AI + Materials | OpenAlex + GS (ML materials design) |
| 🧬 Biopharma | OpenAlex + GS + CNKI (CHO/purification/AI/CGT/CDMO) |

---

## 8 Workflows

| W# | Name | Source | Purpose |
|----|------|--------|------|
| W1 | OpenAlex | REST API | Latest papers (2023+) |
| W2 | Google Scholar CDP | CDP Browser (VPN required) | Cross-decade high-citation reviews |
| W3 | CNKI CDP | CDP Browser (**NO VPN!**) | Chinese full-text + theses |
| W4 | PyMuPDF | PDF Parser | Annual report / patent full-text |
| W5 | Multi-Source Merge & Dedup | Python | Three-source dedup (DOI > title > title+year) |
| W6 | Industry Intelligence | defuddle + scrapling | Market / capacity / supply chain |
| W7 | Patent Search | Google Patents + CNKI | Technology landscape / competitive analysis |
| W8 | AI + Materials | OpenAlex + GS | ML materials design / polymer informatics |

---

## Validated Scenarios

| # | Scenario | Dimensions | Volume |
|---|------|------|:---:|
| 1 | PA11/PA1010 bio-based polyamide 3-source search | Literature/patents/supply chain/capacity | 50 papers |
| 2 | Huafon Chemical 241pp annual report PyMuPDF | Industrial PDF/capacity/finance/supply chain | 458 KB |
| 3 | RSC Lab on a Chip OA paper (44c continuous-flow) | Academic OA/microfluidic purification/smart DSP | 22 pp |
| 4 | Frontiers CGT 4.0 OA paper (4c) | Academic OA/CGT/automation sensors | 6 pp |
| 5 | PHA polyhydroxyalkanoates industry panorama | Literature/market/degradation standards/capacity | 85 hits |
| 6 | AI + polymer materials design frontier | Literature/ML methods/materials informatics | 291 hits |
| 7 | Bio-based materials 3D cross-analysis | 3 directions × 10 dimensions | 60 papers |
| 8 | Google Scholar Chinese citation extraction | "被引用次数：133" regex | Full-width colon |
| 9 | CNKI no-VPN direct CDN pipeline | KNS8 selectors + SSL bypass | 140 hits |
| 10 | Windows 11 UTF-8 permanent fix | Python/PowerShell/Git Bash | Permanent |
| 11 | Biopharma industry panorama | Literature/process/AI/glycosylation/CDMO | 41 hits |
| 12 | WuXi Biologics 263pp annual report PyMuPDF | Industrial PDF/capacity/finance/CDMO | 5yr financials |
| 13 | Samsung Biologics financial verification | Cross-market reports (HKEX/KRX) + Wikipedia | 2023-2024 |

---

## Known Traps (30 total, 7 categories)

1. `print()` Chinese text → crash (always write to UTF-8 file, never print)
2. PS 5.1 instead of 7+ → encoding errors
3. CNKI + VPN → HTTP 418 (CNKI must use direct connection)
4. CDP `/navigate` for CNKI → URL params stripped
5. GS regex without full-width colon → misses all Chinese results
6. CNKI `.page-next` → pagination silently fails
7. GS without VPN (China) → unreachable

Full catalog → [[traps-catalog]]

---

## Network Notes

- **CNKI**: direct connection only (VPN triggers HTTP 418 anti-bot)
- **Google Scholar** (China users): VPN required, proxy `socks5h://127.0.0.1:10808`
- **International users**: all sources directly accessible
- **CDP proxy**: `http://127.0.0.1:3456` (Chrome remote debugging port `9222`)

---

## Triggers

chemical industry research · bio-based materials · polymer market · production capacity · supply chain analysis · technology landscape · competitive analysis · materials patents · AI materials design · annual reports · biopharma · biosimilars · mAb · ADC · CGT · CHO culture · CDMO

---

## License

MIT — [LICENSE](LICENSE)

---

*deep-chem v0.2.0 · Chemical / Bio-Based Materials / Polymer / Life Sciences*
