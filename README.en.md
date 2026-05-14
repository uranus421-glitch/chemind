# deep-chem

> **Chemical / Bio-Based Materials / Polymer / Life Sciences Industry Multi-Dimensional Deep Research**
>
> *化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymer- / Biowissenschaften*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

---

## Positioning / 定位 / Positionierung

`deep-chem` is the **chemical/materials & life sciences industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery. Now with biopharma / CGT / bioprocess dimension.

`deep-chem` 是 `academic-search` 的化工材料与生命科学产业增强层。不止于文献——整合市场数据、专利、标准、产能产量、产业链与 AI 驱动材料发现。新增生物制药/CGT/生物工艺维度。

`deep-chem` ist die Erweiterungsschicht für die chemische/materialbasierte Industrie & Biowissenschaften auf Basis von `academic-search`.

---

## Dimensions Covered / 覆盖维度 / Abgedeckte Dimensionen

| Dimension / 维度 / Dimension | Tools/Sources / 工具/源 / Werkzeuge/Quellen |
|------|------|
| 📚 Academic Literature | OpenAlex + Google Scholar + CNKI (three-source dedup) |
| 📄 Industrial PDFs | PyMuPDF (annual reports, patents) |
| 🏭 Market/Capacity | defuddle + WebSearch + CNKI |
| 🔬 Patents | Google Patents + CNKI patent database |
| 📏 Standards/Regulations | GB/T, ISO, EU, China plastic ban, FDA/EMA |
| 🔗 Supply Chain | Industry reports + associations + annual reports |
| 🤖 AI + Materials | OpenAlex + GS (ML-driven materials design) |
| 🧬 Biopharma | OpenAlex + GS + CNKI (CHO/purification/AI/CGT/CDMO) |

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

Chemical industry research · bio-based materials survey · polymer market · production capacity · supply chain analysis · technology landscape · materials patents · AI materials design · annual report extraction · industry standards · biopharma · biologics · mAb · ADC · CGT · CHO culture · CDMO

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报 · 生物制药 · 生物类似药 · 单抗 · ADC · 细胞基因治疗 · CHO培养 · CDMO

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkettenanalyse · Technologielandschaft · Materialpatente · KI-Materialdesign · Geschäftsberichte · Biopharma · Biologics · mAb · ADC · CGT · CHO-Kultur · CDMO

---

## 8 Workflows / 8 个工作流 / 8 Arbeitsabläufe

| W# | Name / 名称 / Name | Source / 源 / Quelle | Dimension / 维度 / Dimension |
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

| # | Scenario / 场景 / Szenario | Dimensions / 维度 / Dimensionen | Data / 数据量 / Daten |
|---|------|------|:---:|
| 1 | PA11/PA1010 bio-based polyamide three-source search | Literature/patents/supply chain/capacity | 50 papers |
| 2 | Huafon Chemical 241-page annual report PyMuPDF | Industrial PDF/capacity/finance/supply chain | 458KB text |
| 3 | RSC Lab on a Chip OA paper PyMuPDF (44c continuous-flow) | Academic OA PDF/microfluidic/intelligent DSP | 22pp 4.1MB |
| 4 | Frontiers CGT 4.0 OA paper PyMuPDF (4c) | Academic OA PDF/CGT/automation sensors | 6pp 854KB |
| 5 | PHA polyhydroxyalkanoates industry panorama | Literature/market/degradation/capacity/ecosystem | 85 hits |
| 6 | AI + polymer materials design frontier | Literature/ML methods/materials informatics/industry | 291 hits |
| 7 | Bio-based materials industry panorama 3D cross-analysis | 3 directions × 10 dimensions | 60 papers + capacity + standards + TRL |
| 8 | Google Scholar Chinese citation extraction | "被引用次数：133" regex | Full-width colon Regex |
| 9 | CNKI no-VPN direct CDP pipeline | KNS8 selectors + SSL bypass | 140 hits |
| 10 | Windows 11 UTF-8 permanent fix | Python/PowerShell/Git Bash | Permanent fix |
| 11 | Biopharma industry panorama upstream+downstream+AI+CDMO | Literature/process/AI/glycosylation/competitive landscape | 41 hits/TOP15 |

---

## Known Traps / 已知陷阱 / Bekannte Fallen

**30 cataloged traps** (7 categories). See [[traps-catalog]].

| Most Fatal / 最致命 / Tödlichste |
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

*deep-chem v0.2.0 · Chemical/Bio-Based/Polymer/Life Sciences · 化工/生物基/聚合物/生命科学 · Chemie/Biobasiert/Polymere/Biowissenschaften*
