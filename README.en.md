# deep-chem — Chemical & Bio-Based Materials Industry Deep Research

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

**Multi-dimensional deep research skill for chemical engineering, bio-based materials, and polymer industries.**

Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery. Built on `academic-search` for CDP infrastructure.

## Dimensions Covered

| Dimension | Tools/Sources | Notes |
|-----------|-------------|-------|
| 📚 Academic Literature | OpenAlex + Google Scholar + CNKI | Bilingual, three-source dedup |
| 📄 Industrial PDFs | PyMuPDF | Annual reports, patents |
| 🏭 Market/Capacity | defuddle + WebSearch | Industry news, production data |
| 🔬 Patents | Google Patents + CNKI | Technology landscape, competition |
| 📏 Standards | National standards + ISO | Regulatory research |
| 🔗 Supply Chain | Industry reports | Upstream/downstream analysis |
| 🤖 AI + Materials | OpenAlex + GS | ML-driven polymer design, informatics |

## Quick Start

```bash
npx skills install github:uranus421-glitch/deep-chem

# Environment check
bash scripts/check-env.sh

# Prerequisites
pip install PyMuPDF
npx skills install github:uranus421-glitch/academic-search
```

## Triggers

- Chemical industry research, bio-based materials survey
- Polymer market analysis, production capacity
- Supply chain analysis, technology landscape
- Materials patents, AI materials design
- Annual report extraction, industry standards

## 8 Workflows

| W# | Name | Source | Coverage |
|----|------|--------|----------|
| W1 | OpenAlex | REST API | 2023+ latest papers |
| W2 | Google Scholar CDP | CDP browser | Cross-decade high-citation reviews |
| W3 | CNKI CDP | CDP browser | Chinese full-text + theses |
| W4 | PyMuPDF | PDF parser | Annual report/patent extraction |
| W5 | Merge & Dedup | Python | Three-source dedup |
| W6 | Industry Intel | defuddle + scrapling | Market/capacity/supply chain |
| W7 | Patent Search | Google Patents + CNKI | Technology landscape |
| W8 | AI + Materials | OpenAlex + GS | ML materials design |

## Validated Scenarios

- ✅ PA11/PA1010 bio-based polyamide three-source search (50 merged papers)
- ✅ Huafon Chemical 241-page annual report PyMuPDF extraction
- ✅ CNKI no-VPN direct connection pipeline (KNS8 selectors verified)
- ✅ Google Scholar Chinese citation extraction ("被引用次数：133")
- ✅ Windows 11 UTF-8 permanent fix

## Network Notes

- **CNKI**: Direct connection only — VPN triggers HTTP 418 anti-bot blocking
- **Google Scholar** (from China): VPN required — `socks5h://127.0.0.1:10808`
- **International users**: All sources directly accessible

## License

MIT — [LICENSE](LICENSE)
