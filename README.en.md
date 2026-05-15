# synthon

> **From raw data to structured industry insight — a 12-dimension deep research engine.**

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.3.0-green)]()

[中文](README.md) | [Deutsch](README.de.md)

---

## What is synthon?

In organic chemistry, a **synthon** is the smallest structural unit that, when combined, builds a complex molecule. In industry research, each workflow in synthon is a building block — literature, patents, financials, supply chains, regulations — that combine to form a complete, multi-dimensional picture of any company, market, or technology.

synthon is the industry intelligence layer on top of [academic-search](https://github.com/coeus-io/academic-search). Where academic-search excels at finding and analyzing papers, synthon extends into every dimension needed for real-world industry research: from annual report financial extraction to supply chain mapping, from patent landscaping to investment competitor benchmarking.

---

## Architecture

```
┌─────────────────────────────────────────────────────────┐
│                    synthon v0.3.0                        │
│          Industry Intelligence Layer                     │
│                                                         │
│  W1-W3     W4-W5    W6-W8        W9-W12                │
│  Literature PDF      Enterprise   Investment            │
│  Search    Pipeline  Intelligence Research              │
│  ───────   ────────  ───────────  ────────────          │
│  OpenAlex  PyMuPDF   Sogou        AKShare               │
│  GS CDP    Dedup     Patents      SEC EDGAR             │
│  CNKI CDP  Scraping  AI+Industry  Supply Chain          │
│                      (7 domains)  Regulations           │
│                                   Clusters (13 parks)   │
├─────────────────────────────────────────────────────────┤
│                 academic-search                          │
│          CDP Infrastructure                              │
│      Chrome DevTools · Proxy · VPN routing              │
└─────────────────────────────────────────────────────────┘
```

12 workflows across 4 functional groups, built on academic-search's CDP infrastructure.

---

## Try It

Just ask Claude Code — synthon activates automatically:

```bash
# Company deep dive
"Analyze Wanhua Chemical — capacity, annual report, supply chain, competitors"

# Technology landscape
"Literature review on solid-state battery latest advances"

# Investment snapshot
"CATL vs BYD: financial comparison"

# Supply chain mapping
"PU resin supply chain: upstream raw materials and downstream applications"

# Regulatory pathway
"China innovative drug IND application process"
```

---

## 12 Workflows

### Group 1: Literature & Patent

| W# | Workflow | What it does |
|----|----------|-------------|
| W1 | **OpenAlex** | Latest English papers (2023+), via REST API — no VPN, instant |
| W2 | **Google Scholar CDP** | Cross-decade high-citation reviews via CDP browser |
| W3 | **CNKI CDP** | Chinese full-text + theses — **DO NOT use VPN!** |

### Group 2: PDF & Enterprise Intelligence

| W# | Workflow | What it does |
|----|----------|-------------|
| W4 | **PyMuPDF** | Annual report / patent full-text extraction, handles 500+ pages |
| W5 | **Merge & Dedup** | Three-source dedup (DOI > title > title+year) |
| W5b | **Annual Report Scraping** | A-share (Eastmoney) / HKEX / SEC EDGAR batch download, 4-path fallback |
| W6 | **Sogou Enterprise Search** | Chinese company news, industry dynamics, university partnerships |
| W7 | **Patent Search** | Google Patents CDP + CNKI patent database |
| W8 | **AI + Industry** | 7 sub-domains: materials · pharma · chemical · energy · agriculture · cosmetics · investment |

### Group 3: Investment & Strategy

| W# | Workflow | What it does |
|----|----------|-------------|
| W9 | **Investment Research** | AKShare A-share financials + SEC 10-K + competitor benchmarking |
| W10 | **Regulatory Search** | 10 regulators × 6 domain matrices (GB/T, ISO, FDA, EMA, NMPA…) |
| W11 | **Supply Chain Mapping** | UN Comtrade API + upstream/midstream/downstream tree |
| W12 | **Industrial Clusters** | 13 reference parks across 7 countries + policy incentives |

---

## Domain Coverage

10 industry dimensions, each with verified toolchain:

| Dimension | Tools | Verified |
|------|------|:---:|
| 📚 Academic Literature | OpenAlex + GS + CNKI → 3-source dedup | ✅ 19 scenarios |
| 📄 Industrial PDFs | PyMuPDF → structured financials | ✅ 2 annual reports |
| 🏭 Market & Capacity | Sogou + annual reports + government sites | ✅ 3 enterprises |
| 🔬 Patents | Google Patents CDP + CNKI patent DB | ✅ W7 pipeline |
| 📏 Standards & Regulations | 10 regulatory bodies × 6 domain matrices | ✅ W10 pipeline |
| 🔗 Supply Chain | UN Comtrade + Sogou + annual reports | ✅ PU resin chain |
| 🤖 AI + Industry | 7 sub-branches across all industries | ✅ W8 pipeline |
| 💰 Investment | AKShare + SEC EDGAR + HKEX CDP | ✅ 3 A-share companies |
| 🏗️ Industrial Clusters | 13 parks across 7 countries | ✅ W12 reference |
| 🧬 Biopharma | Literature + process + AI + glycosylation + CDMO | ✅ 3 scenarios |

---

## Real-World Validations

Every workflow validated against real data:

| # | Scenario | Data | Key Insight |
|---|------|:---:|------|
| 1 | PA11/PA1010 bio-based polyamide | 50 papers | 3-source lit review pipeline |
| 2 | BASF 2024 annual report | ~280 pp | Financial + capacity + Verbund extraction |
| 5 | PHA industry panorama | 85 hits | Literature + market + degradation standards |
| 6 | AI + polymer materials design | 291 hits | Cross-domain ML frontier mapping |
| 11 | Biopharma industry panorama | 41 papers | CHO/purification/CGT/CDMO |
| 14 | Sogou enterprise search | 3 companies | Chinese enterprise news pipeline |
| 17 | Solid-state battery landscape | Lit + news | Academic + industry cross-validation |
| 18 | Alternative protein market | Academic + invest | Food tech multi-dimension |
| 19 | Active peptide cosmetics ingredients | Lit + enterprise | Cosmetics raw material pipeline |

Full 19 validated scenarios in [SKILL.md](SKILL.md).

---

## Traps & Pitfalls

53 documented traps across 16 categories — each with root cause and fix. Industry research breaks in predictable ways. These are the ones we've already documented and solved:

| Top traps |
|------|
| `print()` Chinese → crash (write to UTF-8 file instead) |
| PS 5.1 breaks Chinese bracket syntax (use PS 7+) |
| CNKI + VPN = HTTP 418 (direct connection only) |
| AKShare column names drift between versions |
| Eastmoney PDF API returns empty (multi-path fallback) |
| Sogou CSS selector class variants |

Full catalog → [traps-catalog.md](references/traps-catalog.md)

---

## Installation

### Prerequisites

| Component | Min | For |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF, akshare, secedgar |
| Node.js | 18+ | CDP browser control |
| PowerShell | 7+ (**not** 5.1) | Windows UTF-8 compatibility |
| Chrome | Latest | Remote debugging (`chrome://inspect`) |

### One command

```bash
bash <(curl -sL https://raw.githubusercontent.com/coeus-io/synthon/master/install.sh)
```

### Step by step

```bash
npx skills install github:coeus-io/synthon
npx skills install github:coeus-io/academic-search
python3 -m pip install PyMuPDF akshare secedgar defuddle requests
bash ~/.claude/skills/synthon/scripts/check-env.sh
```

---

## Network

| Source | Access from China | Method |
|--------|:---:|------|
| OpenAlex | ✅ Direct | `curl` REST API |
| Sogou | ✅ Direct | `curl` HTML extraction |
| CNKI | ✅ Direct (**NO VPN!**) | CDP browser |
| Google Scholar | 🚧 VPN required | CDP browser + proxy |
| Google Patents | 🚧 VPN required | CDP browser + proxy |
| SEC EDGAR | 🚧 VPN required | `secedgar` library |
| UN Comtrade | ✅ Direct | `curl` API |

---

## Related

| Resource | Description |
|------|------|
| [academic-search](https://github.com/coeus-io/academic-search) | CDP infrastructure this skill builds on |
| [SKILL.md](SKILL.md) | Full skill definition & workflow reference |
| [traps-catalog.md](references/traps-catalog.md) | 53 documented traps (16 categories) |

---

## License

MIT — [LICENSE](LICENSE)

---

*synthon v0.3.0 · Built on academic-search · Chemical / Materials / Biopharma / Supply Chain / Investment — 12-Dimension Industry Deep Research Engine*
