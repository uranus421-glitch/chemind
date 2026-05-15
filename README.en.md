# synthon

> Multi-dimensional deep research Claude Code Skill for chemical, bio-based materials, polymer & life sciences industries

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.3.0-green)]()

[中文](README.md) | [Deutsch](README.de.md)

---

## What It Does

`synthon` is the **chemical/materials & life sciences industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, AI-driven materials discovery, investment research, and industrial cluster mapping. Now with biopharma / CGT dimension.

---

## Installation

### Prerequisites

| Component | Minimum | Notes |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF, akshare, secedgar, requests for PDF extraction / investment data / SEC filings |
| Node.js | 18+ | CDP browser control (core academic-search dependency) |
| PowerShell | 7+ (**not** 5.1) | PS 5.1 has UTF-8 bugs that break CJK text |
| Chrome / Chromium | Latest stable | Remote debugging mode (`chrome://inspect`) |

**Platforms**: Windows 11 ✅ | macOS ✅ | Linux ✅ (WSL2 recommended on Windows)

### One-Command Install

```bash
bash <(curl -sL https://raw.githubusercontent.com/coeus-io/synthon/master/install.sh)
```

This handles: skill install → academic-search dependency → Python deps (PyMuPDF, akshare, secedgar, defuddle) → environment check.

### Manual Install

```bash
# 1. Install the skill
npx skills install github:coeus-io/synthon

# 2. Install CDP infrastructure
npx skills install github:coeus-io/academic-search

# 3. Install Python dependencies
python3 -m pip install PyMuPDF akshare secedgar defuddle requests

# 4. Verify environment
bash ~/.claude/skills/synthon/scripts/check-env.sh
```

### Verify

Activate by mentioning any trigger in Claude Code:

> chemical industry research · bio-based materials · polymer market · annual reports · biopharma · CDMO · investment research · supply chain · industrial parks

---

## Dimensions Covered

| Dimension | Tools/Sources |
|------|------|
| 📚 Academic Literature | OpenAlex + Google Scholar + CNKI |
| 📄 Industrial PDFs | PyMuPDF (annual reports / patents) |
| 🏭 Market & Capacity | Sogou + WebSearch + annual reports |
| 🔬 Patents | Google Patents CDP + CNKI patent database |
| 📏 Standards & Regulations | 10 regulators (GB/T, ISO, EU, FDA/EMA, NMPA, etc.) |
| 🔗 Supply Chain | UN Comtrade API + industry reports + annual reports |
| 🤖 AI + Industry | Materials informatics / AI pharma / AI energy / AI agri / AI cosmetics |
| 💰 Investment Research | AKShare (A-share) + SEC EDGAR + HKEX CDP |
| 🏗️ Industrial Clusters | 13 reference parks across 7 countries |
| 🧬 Biopharma | OpenAlex + GS + CNKI (CHO/purification/CGT/CDMO) |

---

## 12 Workflows

| W# | Name | Source | Purpose |
|----|------|--------|------|
| W1 | OpenAlex | REST API | Latest papers (2023+) |
| W2 | Google Scholar CDP | CDP Browser (VPN required) | Cross-decade high-citation reviews |
| W3 | CNKI CDP | CDP Browser (**NO VPN!**) | Chinese full-text + theses |
| W4 | PyMuPDF | PDF Parser | Annual report / patent full-text extraction |
| W5 | Multi-Source Merge & Dedup | Python | Three-source dedup (DOI > title > title+year) |
| W5b | Annual Report Scraping | Eastmoney + SEC EDGAR + HKEX CDP | A-share/US/HK batch download & analysis |
| W6 | Sogou Enterprise Search | Sogou curl + HTML extraction | Chinese enterprise news / industry dynamics |
| W7 | Patent Search | Google Patents CDP + CNKI | Technology landscape / competitive analysis |
| W8 | AI + Industry | OpenAlex + GS + industry sources | AI materials / pharma / energy / agri / cosmetics (7 sub-branches) |
| W9 | Investment Research | AKShare + SEC EDGAR + HKEX | A-share financials / 10-K / competitor benchmarking |
| W10 | Regulatory Search | 10 regulators × 6 domain matrices | Standards / approvals / compliance pathways |
| W11 | Supply Chain Mapping | UN Comtrade + Sogou + annual reports | Upstream/midstream/downstream mapping |
| W12 | Industrial Clusters | Sogou + government sites + annual reports | 13 parks / policy incentives / capacity aggregation |

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
| 9 | CNKI no-VPN direct CDP pipeline | KNS8 selectors + SSL bypass | 140 hits |
| 10 | Windows 11 UTF-8 permanent fix | Python/PowerShell/Git Bash | Permanent |
| 11 | Biopharma industry panorama | Literature/process/AI/glycosylation/CDMO | 41 hits |
| 12 | WuXi Biologics 263pp annual report PyMuPDF | Industrial PDF/capacity/finance/CDMO | 5yr financials |
| 13 | Samsung Biologics financial verification | Cross-market reports (HKEX/KRX) + Wikipedia | 2023-2024 |
| 14 | Sogou Chinese enterprise search | 华峰化学/万华化学/宁德时代 capacity + market | 3 companies |
| 15 | Specialty chemicals supply chain | 华峰化学 PU resin upstream/downstream | Full chain map |
| 16 | Agrochemical: crop protection | 先正达/扬农化工 Sogou + OpenAlex | 2 companies + literature |
| 17 | Energy materials: solid-state battery | CATL/QuantumScape OpenAlex + Sogou | Literature + industry |
| 18 | Food tech: alternative protein | OpenAlex + Sogou + investment data | Academic + industry |
| 19 | Cosmetics ingredients: active peptides | 珀莱雅/华熙生物 OpenAlex + Sogou | Literature + enterprise |

---

## Known Traps (53 total, 16 categories)

1. `print()` Chinese text → crash (always write to UTF-8 file, never print)
2. PS 5.1 instead of 7+ → encoding errors
3. CNKI + VPN → HTTP 418 (CNKI must use direct connection)
4. CDP `/navigate` for CNKI → URL params stripped
5. GS regex without full-width colon → misses all Chinese results
6. CNKI `.page-next` → pagination silently fails
7. GS without VPN (China) → unreachable
8. AKShare column name mismatch → 归母净利润 vs 扣非净利润
9. Eastmoney PDF API returns empty → anti-scraping → multi-path fallback
10. Sogou `fz-mid` selector class variants → HTML class differs from pattern

Full catalog → [[traps-catalog]]

---

## Network Notes

- **CNKI**: direct connection only (VPN triggers HTTP 418 anti-bot)
- **Google Scholar** (China users): VPN required, proxy `socks5h://127.0.0.1:10808`
- **International users**: all sources directly accessible
- **CDP proxy**: `http://127.0.0.1:3456` (Chrome remote debugging port `9222`)

---

## Triggers

chemical industry research · bio-based materials · polymer market · production capacity · supply chain analysis · technology landscape · competitive analysis · materials patents · AI materials design · annual reports · investment research · competitor benchmarking · regulatory pathway · supply chain mapping · industrial parks · chemical parks · biopharma · biosimilars · mAb · ADC · CGT · CHO culture · CDMO · specialty chemicals · agrochemicals · energy materials · food tech · cosmetics ingredients

---

## License

MIT — [LICENSE](LICENSE)

---

*synthon v0.3.0 · Chemical / Bio-Based Materials / Polymer / Life Sciences*
