# deep-lit — Chemical & Materials Industrial Literature Deep Research Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.1.0-green)]()

**Claude Code Skill for chemical/materials industrial literature research.**
Built on `academic-search` with domain-specific enhancements for polymers, bio-based materials, and chemical engineering.

---

## Positioning

`deep-lit` is **not** a replacement for `academic-search` — it's a **chemical/materials domain enhancement layer**:

- `academic-search` → General academic search infrastructure (CDP proxy, API cookbook, multi-platform matrix)
- `deep-lit` → Production battle-tested field manual for chemical/materials research (concrete commands, 28 cataloged traps, Chinese-specific handling, industrial PDF workflows)

## Why deep-lit?

| Scenario | academic-search | deep-lit |
|----------|:---:|:---:|
| General academic literature search | ✅ | — |
| Polymer/bio-based materials focused search | — | ✅ |
| CNKI KNS8 DOM selectors | — | ✅ |
| Google Scholar Chinese citation extraction | — | ✅ |
| Windows UTF-8 encoding permanent fix | — | ✅ |
| Industrial PDF (annual reports/patents) extraction | — | ✅ |
| 28 cataloged known traps | — | ✅ |
| Chinese+English bilingual merge & dedup | — | ✅ |

## Quick Start

```bash
# Install
npx skills install github:uranus421/deep-lit

# Verify
npx skills list | grep deep-lit

# Environment check
bash scripts/check-env.sh
```

### Prerequisites

```bash
# 1. academic-search (CDP infrastructure)
npx skills install github:uranus421/academic-search

# 2. Python dependencies
pip install PyMuPDF

# 3. Node.js 22+
node --version
```

## Triggers (Auto-Activation)

The skill activates automatically when Claude Code conversations mention:

- Industrial/chemical/materials literature search
- Polymer/bio-based materials research
- CNKI (China National Knowledge Infrastructure) search
- Annual report or patent PDF extraction
- Bilingual (Chinese+English) literature merge
- Industry research or technology surveys

## Workflows

| Workflow | Source | Description |
|----------|--------|-------------|
| **W1** | OpenAlex API | 2023+ latest English papers, OA status |
| **W2** | Google Scholar CDP | Cross-decade high-citation reviews, authoritative citation counts |
| **W3** | CNKI CDP | Full Chinese coverage + theses |
| **W4** | PyMuPDF | Annual report / patent PDF text extraction |
| **W5** | Python merge | Three-source dedup & merge |

## Directory Structure

```
deep-lit/
├── SKILL.md                         # Main skill file
├── README.md                        # Chinese documentation
├── README.en.md                     # This file (English)
├── LICENSE                          # MIT
├── .gitignore
├── references/
│   ├── traps-catalog.md             # 28 known traps (by platform)
│   ├── cnki-kns8-selectors.md       # CNKI KNS8 DOM selector reference
│   ├── scholar-chinese-citations.md # Google Scholar Chinese citation extraction
│   ├── windows-utf8-fix.md          # Windows UTF-8 permanent fix
│   ├── pymupdf-industrial.md        # PyMuPDF industrial PDF extraction guide
│   └── merge-dedup.md               # Multi-source dedup Python code
└── scripts/
    └── check-env.sh                 # Environment check script
```

## Validated Scenarios

- ✅ PA11/PA1010 long-chain bio-based polyamide three-source literature search
- ✅ Huafon Chemical 241-page annual report full PyMuPDF extraction
- ✅ Google Scholar Chinese citation count "被引用次数：133" parsing
- ✅ CNKI KNS8 CAPTCHA / SSL / location.href full pipeline
- ✅ Windows 11 Git Bash + PowerShell 7+ UTF-8 encoding permanent fix

## Roadmap

- **v0.1.0** ← Current: 4 workflows + 28 traps + 6 references
- **v0.2.0**: Chemical industry site patterns (chemnews, ccfa, etc.)
- **v0.3.0**: Patent search workflow (Google Patents CDP)
- **v1.0.0**: User feedback stable + 3+ production validations

## Network Notice (China Users)

Google Scholar and overseas publisher PDFs require VPN access from within China. The skill will prompt you to enable VPN when needed. Proxy: `socks5h://127.0.0.1:10808`.

For users outside China, all sources are directly accessible.

## License

MIT — see [LICENSE](LICENSE)

---

*Made for real chemical/materials industry research. Not academic in theory — validated in production.*
