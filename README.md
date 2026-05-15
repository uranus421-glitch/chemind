# synthon

> **Chemical / Bio-Based Materials / Polymer / Life Sciences Industry Multi-Dimensional Deep Research Claude Code Skill**
>
> *化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymer- / Biowissenschaften*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.3.0-green)]()

[English](README.en.md) | [中文](README.md) | [Deutsch](README.de.md)

---

## Positioning / 定位 / Positionierung

`synthon` is the **chemical/materials & life sciences industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, AI-driven materials discovery, investment research, and industrial cluster mapping. Now with biopharma / CGT dimension.

`synthon` 是 `academic-search` 的**化工材料与生命科学产业增强层**。不止于文献——整合市场数据、专利、标准、产能产量、产业链、AI 驱动材料发现、投资分析与产业聚集区。新增生物制药/细胞基因治疗维度。

`synthon` ist die **Erweiterungsschicht für die chemische/materialbasierte Industrie & Biowissenschaften** auf Basis von `academic-search`. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten, KI-gestützte Materialentdeckung, Investmentanalyse und Industriecluster-Mapping. Jetzt mit Biopharma/CGT-Dimension.

---

## Installation / 安装 / Installation

### Requirements / 环境要求 / Voraussetzungen

| Component / 组件 / Komponente | Min Version | Notes / 说明 / Hinweise |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF, akshare, secedgar, requests for PDF extraction / investment data / SEC filings |
| Node.js | 18+ | CDP browser control (core academic-search dependency) |
| PowerShell | 7+ (**not** 5.1) | PS 5.1 has UTF-8 encoding bugs with Chinese / PS 5.1 中文编码 bug / PS 5.1 UTF-8-Fehler |
| Chrome / Chromium | Latest stable | Remote debugging mode (`chrome://inspect`) |

**Platform**: Windows 11 ✅ | macOS ✅ | Linux ✅ (WSL2 recommended for Windows)

### One-Command Install / 一键安装 / Ein-Klick-Installation

```bash
bash <(curl -sL https://raw.githubusercontent.com/coeus-io/synthon/master/install.sh)
```

Auto-completes: skill install → academic-search dependency → Python deps (PyMuPDF, akshare, secedgar, defuddle) → environment check

### Step-by-Step / 分步安装 / Schrittweise

```bash
# 1. Install skill
npx skills install github:coeus-io/synthon

# 2. Install CDP infrastructure
npx skills install github:coeus-io/academic-search

# 3. Install Python dependencies
python3 -m pip install PyMuPDF akshare secedgar defuddle requests

# 4. Verify environment
bash ~/.claude/skills/synthon/scripts/check-env.sh
```

### Verification / 验证 / Verifikation

Type any trigger in Claude Code to activate:

> Chemical industry research · bio-based materials · polymer market · annual reports · biopharma · CDMO · CGT · investment research · supply chain mapping · industrial parks
>
> 化工产业研究 · 生物基材料调研 · 聚合物市场 · 上市公司年报 · 生物制药 · CDMO · 投资分析 · 产业链 · 产业园
>
> Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Geschäftsberichte · Biopharma · Investmentanalyse · Lieferkette · Industrieparks

---

## Dimensions Covered / 覆盖维度 / Abgedeckte Dimensionen

| Dimension / 维度 | Tools / Sources / Quellen |
|------|------|
| 📚 Academic Literature / 学术文献 / Wissenschaftliche Literatur | OpenAlex + Google Scholar + CNKI |
| 📄 Industrial PDFs / 工业 PDF / Industrielle PDFs | PyMuPDF (annual reports / patents) |
| 🏭 Market & Capacity / 市场与产能 / Markt & Kapazität | Sogou + WebSearch + annual reports |
| 🔬 Patents / 专利 / Patente | Google Patents CDP + CNKI patent database |
| 📏 Standards & Regulations / 标准与法规 / Normen | 10 regulators (GB/T, ISO, EU, FDA/EMA, NMPA, etc.) |
| 🔗 Supply Chain / 产业链 / Lieferkette | UN Comtrade API + industry reports + annual reports |
| 🤖 AI + Industry / AI+产业 / KI+Industrie | Materials informatics / AI pharma / AI energy / AI agri / AI cosmetics |
| 💰 Investment Research / 投资研究 / Investmentanalyse | AKShare (A-share) + SEC EDGAR + HKEX CDP |
| 🏗️ Industrial Clusters / 产业聚集区 / Industriecluster | 13 reference parks across 7 countries |
| 🧬 Biopharma / 生物制药 / Biopharma | OpenAlex + GS + CNKI (CHO/purification/CGT/CDMO) |

---

## 12 Workflows / 12 个工作流 / 12 Arbeitsabläufe

| W# | Name | Source / 数据源 / Quelle | Purpose / 用途 / Zweck |
|----|------|--------|------|
| W1 | OpenAlex | REST API | 2023+ latest papers / 最新论文 / Neueste Arbeiten |
| W2 | Google Scholar CDP | CDP Browser (VPN required in China) | Cross-decade high-citation reviews / 跨年代高引综述 |
| W3 | CNKI CDP | CDP Browser (**NO VPN!**) | Chinese full-text + theses / 中文全量+学位论文 |
| W4 | PyMuPDF | PDF Parser | Annual report / patent full-text extraction / 年报/专利全文提取 |
| W5 | Merge & Dedup | Python | Three-source dedup (DOI > title > title+year) / 三源去重 |
| W5b | Annual Report Scraping | Eastmoney + SEC EDGAR + HKEX CDP | A-share/US/HK batch download & analysis / 年报批量爬取 |
| W6 | Sogou Enterprise Search | Sogou curl + HTML extraction | Chinese enterprise news / industry dynamics / 企业新闻/行业动态 |
| W7 | Patent Search | Google Patents CDP + CNKI | Technology landscape / competitive analysis / 技术路线/竞争格局 |
| W8 | AI + Industry | OpenAlex + GS + industry sources | AI materials / pharma / energy / agri / cosmetics / 7 sub-branches |
| W9 | Investment Research | AKShare + SEC EDGAR + HKEX | A-share financials / 10-K / competitor benchmarking / 投资分析 |
| W10 | Regulatory Search | 10 regulators × 6 domain matrices | Standards / approvals / compliance pathways / 法规标准检索 |
| W11 | Supply Chain Mapping | UN Comtrade + Sogou + annual reports | Upstream/midstream/downstream / 产业链映射 |
| W12 | Industrial Clusters | Sogou + government sites + annual reports | 13 parks / policy incentives / capacity aggregation / 产业聚集区 |

---

## Validated Scenarios / 已验证场景 / Validierte Szenarien

| # | Scenario / 场景 / Szenario | Dimensions / 维度 | Data / 数据量 |
|---|------|------|:---:|
| 1 | PA11/PA1010 bio-based polyamide three-source search | Literature / patents / supply chain / capacity | 50 papers |
| 2 | Huafon Chemical 241-page annual report PyMuPDF extraction | Industrial PDF / capacity / finance / supply chain | 458 KB |
| 3 | RSC Lab on a Chip OA paper (44c continuous flow) | Academic OA / microfluidics purification / smart downstream | 22 pages |
| 4 | Frontiers CGT 4.0 OA paper (4c) | Academic OA / CGT / automation sensors | 6 pages |
| 5 | PHA polyhydroxyalkanoates industry panorama | Literature / market / degradation standards / capacity | 85 hits |
| 6 | AI + polymer materials design frontier | Literature / ML methods / materials informatics / industry | 291 hits |
| 7 | Bio-based materials industry panorama 3D cross-analysis | 3 directions × 10 dimensions | 60 papers |
| 8 | Google Scholar Chinese citation extraction | "被引用次数：133" regex | Full-width colon Regex |
| 9 | CNKI no-VPN direct CDP pipeline | KNS8 selectors + SSL bypass | 140 hits |
| 10 | Windows 11 UTF-8 permanent fix | Python / PowerShell / Git Bash | Permanent fix |
| 11 | Biopharma industry panorama | Literature / process / AI / glycosylation / CDMO | 41 papers |
| 12 | WuXi Biologics 263-page annual report PyMuPDF | Industrial PDF / capacity / finance / CDMO | 5-year financials |
| 13 | Samsung Biologics financial verification | Cross-market reports (HK/KR) + Wikipedia | 2023-2024 |
| 14 | Sogou Chinese enterprise search | 华峰化学/万华化学/宁德时代产能+市场 | 3 companies |
| 15 | Specialty chemicals supply chain | 华峰化学 PU resin upstream/downstream | Full chain map |
| 16 | Agrochemical industry: crop protection | 先正达/扬农化工 Sogou + OpenAlex | 2 companies + literature |
| 17 | Energy materials: solid-state battery | CATL/QuantumScape OpenAlex + Sogou | Literature + industry news |
| 18 | Food tech: alternative protein | OpenAlex + Sogou + investment data | Academic + industry |
| 19 | Cosmetics ingredients: active peptides | 珀莱雅/华熙生物 OpenAlex + Sogou | Literature + enterprise |

---

## Known Traps / 已知陷阱 / Bekannte Fallen

**53 cataloged traps** (16 categories). See [traps-catalog](references/traps-catalog.md).

**53 个已编目陷阱** (16 类)。详见 [traps-catalog](references/traps-catalog.md)。

**53 katalogisierte Fallen** (16 Kategorien). Siehe [traps-catalog](references/traps-catalog.md).

| # | Trap / 陷阱 / Falle | Impact / 影响 / Auswirkung |
|---|------|------|
| 1 | `print()` Chinese → crash / 崩溃 / Absturz | All Python workflows |
| 2 | PS 5.1 instead of 7+ / PS 5.1 而非 7+ | `[建议]` parsed as array operator / 编码错误 |
| 3 | CNKI + VPN → HTTP 418 | CNKI fully blocked / 封锁 / Blockierung |
| 4 | CDP `/navigate` for CNKI | URL params stripped / 参数截断 |
| 5 | GS regex without full-width colon | Misses Chinese results / 丢失中文引用 |
| 6 | CNKI `.page-next` failure | Pagination silently fails / 翻页静默失败 |
| 7 | GS without VPN (China) | Site unreachable / 不可达 / Nicht erreichbar |
| 8 | AKShare column name mismatch | 归母净利润 vs 扣非净利润 / API field drift |
| 9 | Eastmoney PDF API returns empty | Anti-scraping → multi-path fallback / 反爬→降级 |
| 10 | Sogou `fz-mid` selector class variants | HTML class differs from pattern / 类名变体 |

---

## Network Notes / 网络说明 / Netzwerk-Hinweise

All ports below are **local-only** (127.0.0.1), never exposed to the internet. Configurable via environment variables.

以下端口均为**本地端口**，不暴露在公网。可通过环境变量配置。

Alle Ports sind **nur lokal**, niemals dem Internet ausgesetzt. Konfigurierbar über Umgebungsvariablen.

- **CNKI**: MUST use direct connection — VPN triggers HTTP 418 anti-bot / 必须直连 / MUSS Direktverbindung nutzen
- **Google Scholar** (from China): VPN required — `socks5h://127.0.0.1:10808` (default local SOCKS5 proxy) / 需 VPN
- **CDP Proxy**: `http://127.0.0.1:3456` (default local proxy, connects to Chrome DevTools on port 9222) / CDP 代理默认端口
- **International users**: All sources directly accessible / 所有源可直接访问 / Alle Quellen direkt zugänglich

---

## Triggers / 触发词 / Auslöser

Chemical industry research · bio-based materials survey · polymer market · production capacity · supply chain analysis · technology landscape · competitive analysis · materials patents · AI materials design · annual report extraction · investment research · competitor benchmarking · regulatory pathway · supply chain mapping · industrial parks · chemical parks · biopharma · biosimilars · mAb · ADC · cell & gene therapy · CHO culture · CDMO · specialty chemicals · agrochemicals · energy materials · food tech · cosmetics ingredients

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报 · 投资分析 · 竞品对标 · 法规路径 · 产业链映射 · 产业园 · 化工区 · 生物制药 · 生物类似药 · 单抗 · ADC · 细胞基因治疗 · CHO培养 · CDMO · 精细化工 · 农用化学品 · 能源材料 · 食品科技 · 化妆品原料

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkettenanalyse · Technologielandschaft · Materialpatente · KI-Materialdesign · Geschäftsberichte · Investmentanalyse · Wettbewerbs-Benchmarking · Regulierungspfad · Lieferketten-Mapping · Industrieparks · Chemieparks · Biopharma · Biosimilars · mAb · ADC · Zell- & Gentherapie · CHO-Kultur · CDMO · Feinchemikalien · Agrochemikalien · Energiematerialien · Lebensmitteltechnologie · Kosmetik-Rohstoffe

---

## License / 许可证 / Lizenz

MIT — [LICENSE](LICENSE)

---

*synthon v0.3.0 · Chemical / Bio-Based / Polymer / Life Sciences · 化工 / 生物基 / 聚合物 / 生命科学 · Chemie / Biobasiert / Polymere / Biowissenschaften*
