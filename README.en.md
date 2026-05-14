# deep-chem

> **Chemical / Bio-Based Materials / Polymer Industry Multi-Dimensional Deep Research**
>
> *化工 / 生物基材料 / 聚合物产业的多维度深度研究*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymerindustrie*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

---

## Positioning / 定位 / Positionierung

`deep-chem` is the **chemical/materials industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery.

`deep-chem` 是 `academic-search` 的化工材料产业增强层。不止于文献——整合市场数据、专利、标准、产能产量、产业链与 AI 驱动材料发现。

`deep-chem` ist die Erweiterungsschicht für die chemische/materialbasierte Industrie auf Basis von `academic-search`.

---

## Dimensions Covered / 覆盖维度 / Abgedeckte Dimensionen

| Dimension | Tools/Sources |
|------|------|
| 📚 Academic Literature | OpenAlex + Google Scholar + CNKI (three-source dedup) |
| 📄 Industrial PDFs | PyMuPDF (annual reports, patents) |
| 🏭 Market/Capacity | defuddle + WebSearch + CNKI |
| 🔬 Patents | Google Patents + CNKI patent database |
| 📏 Standards/Regulations | GB/T, ISO, EU, China plastic ban |
| 🔗 Supply Chain | Industry reports + associations + annual reports |
| 🤖 AI + Materials | OpenAlex + GS (ML-driven materials design) |

---

## Quick Start / 快速开始 / Schnellstart

```bash
npx skills install github:uranus421-glitch/deep-chem
bash scripts/check-env.sh
pip install PyMuPDF
npx skills install github:uranus421-glitch/academic-search
```

---

## Triggers / 触发词 / Auslöser

Chemical industry research · bio-based materials survey · polymer market · production capacity · supply chain analysis · technology landscape · materials patents · AI materials design · annual report extraction · industry standards

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkettenanalyse · Technologielandschaft · Materialpatente · KI-Materialdesign · Geschäftsberichte

---

## 8 Workflows / 8 个工作流 / 8 Arbeitsabläufe

| W# | Name | Source | Dimension |
|----|------|--------|----------|
| W1 | OpenAlex | REST API | 2023+ latest papers |
| W2 | Google Scholar CDP | CDP Browser (VPN required in China) | Cross-decade high-citation reviews |
| W3 | CNKI CDP | CDP Browser (NO VPN!) | Chinese full-text + theses |
| W4 | PyMuPDF | PDF Parser | Annual report/patent extraction |
| W5 | Merge & Dedup | Python | Three-source dedup |
| W6 | Industry Intel | defuddle + scrapling | Market/capacity/supply chain |
| W7 | Patent Search | Google Patents + CNKI | Technology landscape |
| W8 | AI + Materials | OpenAlex + GS | ML materials design |

---

## Validated Scenarios / 已验证场景 / Validierte Szenarien

| # | Scenario | Dimensions | Data |
|---|------|------|:---:|
| 1 | PA11/PA1010 bio-based polyamide three-source search | Literature/patents/supply chain/capacity | 50 papers |
| 2 | Huafon Chemical 241-page annual report PyMuPDF extraction | Industrial PDF/capacity/finance/supply chain | 458KB text |
| 3 | PHA polyhydroxyalkanoates industry panorama | Literature/market/degradation standards/capacity/ecosystem | 85 hits |
| 4 | AI + polymer materials design frontier | Literature/ML methods/materials informatics/industry | 291 hits |
| 5 | Bio-based materials industry panorama 3D cross-analysis | 3 directions × 10 dimensions | 60 papers + capacity + standards + TRL |
| 6 | Google Scholar Chinese citation extraction | "被引用次数：133" regex | Full-width colon Regex |
| 7 | CNKI no-VPN direct CDP pipeline | KNS8 selectors + SSL bypass | 140 hits |
| 8 | Windows 11 UTF-8 permanent fix | Python/PowerShell/Git Bash | Permanent fix |

---

## Known Traps / 已知陷阱 / Bekannte Fallen

**30 cataloged traps** (7 categories). See [[traps-catalog]].

| Most Fatal |
|---|
| 1. `print()` Chinese → crash |
| 2. PS 5.1 instead of 7+ → encoding errors |
| 3. CNKI + VPN → HTTP 418 block |
| 4. CDP `/navigate` for CNKI → URL params stripped |
| 5. GS regex without full-width colon → misses Chinese results |
| 6. CNKI `.page-next` → pagination silently fails |
| 7. GS without VPN (China) → unreachable |

---

## Network Notes / 网络说明 / Netzwerk-Hinweise

- **CNKI**: MUST use direct connection — VPN triggers HTTP 418 anti-bot
- **Google Scholar** (from China): VPN required — `socks5h://127.0.0.1:10808`
- **International users**: All sources directly accessible

---

## License / 许可证 / Lizenz

MIT — [LICENSE](LICENSE)

---

*deep-chem v0.2.0 · Chemical/Bio-Based/Polymer · 化工/生物基/聚合物 · Chemie/Biobasiert/Polymere*
