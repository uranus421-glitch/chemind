# synthon

> **From raw data to structured industry insight — a 12-dimension deep research engine.**
>
> *投进去的是问题，出来的是结构化的产业知识图谱。*
>
> *Rohdaten rein, strukturierte Industrie-Insights raus.*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.3.0-green)]()

[English](README.en.md) | [中文](README.md) | [Deutsch](README.de.md)

---

## What is synthon? / 什么是 synthon？ / Was ist synthon？

In organic chemistry, a **synthon** is the smallest structural unit that, when combined, builds a complex molecule. In industry research, each workflow in synthon is a building block — literature, patents, financials, supply chains, regulations — that combine to form a complete, multi-dimensional picture of any company, market, or technology.

**synthon** is the industry intelligence layer on top of [academic-search](https://github.com/coeus-io/academic-search). Where academic-search excels at finding and analyzing papers, synthon extends into every dimension needed for real-world industry research.

在有机化学中，**合成子（synthon）**是构建复杂分子的最小结构单元。在产业研究中，synthon 的每个工作流就是一个合成子——文献、专利、财务、产业链、法规——组合起来形成对任何公司、市场或技术的完整多维画像。

In der organischen Chemie ist ein **Synthon** die kleinste Struktureinheit, die kombiniert ein komplexes Molekül aufbaut. In der Industrieforschung ist jeder Workflow in synthon ein Baustein — Literatur, Patente, Finanzen, Lieferketten, Vorschriften — die zusammen ein vollständiges, mehrdimensionales Bild eines Unternehmens, Marktes oder einer Technologie ergeben.

---

## Architecture / 架构 / Architektur

```
┌─────────────────────────────────────────────────────────┐
│                    synthon v0.3.0                        │
│          Industry Intelligence Layer / 产业情报层         │
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
│          CDP Infrastructure / CDP 基础设施               │
│      Chrome DevTools · Proxy · VPN routing              │
└─────────────────────────────────────────────────────────┘
```

12 workflows across 4 functional groups, built on academic-search's CDP infrastructure.

12 个工作流分属 4 个功能组，基于 academic-search 的 CDP 基础设施。

12 Arbeitsabläufe in 4 Funktionsgruppen, auf CDP-Infrastruktur von academic-search.

---

## Try It / 试一试 / Ausprobieren

Just ask Claude Code any of these — synthon activates automatically:

在 Claude Code 中直接提问——synthon 自动激活：

```bash
# Company deep dive / 公司深度研究
"分析万华化学——产能、年报、产业链、竞品"

# Technology landscape / 技术路线
"文献综述固态电池最新进展"

# Investment snapshot / 投资快照  
"宁德时代 vs 比亚迪：财务对比"

# Supply chain / 产业链
"PU 树脂产业链上游原料和下游应用"

# Regulatory pathway / 法规路径
"中国创新药 IND 申报流程"
```

---

## 12 Workflows / 12 个工作流 / 12 Arbeitsabläufe

### Group 1: Literature & Patent / 文献专利组

| W# | Workflow | What it does | 做什么 |
|----|----------|-------------|--------|
| W1 | **OpenAlex** | Latest English papers (2023+), via REST API — no VPN, instant | 最新英文论文，REST API 秒级响应 |
| W2 | **Google Scholar CDP** | Cross-decade high-citation reviews via CDP browser | 跨年代高引综述 |
| W3 | **CNKI CDP** | Chinese full-text + theses — **DO NOT use VPN!** | 中文全量+学位论文，**禁止 VPN** |

### Group 2: PDF & Enterprise Intelligence / 工业 PDF 与企业情报组

| W# | Workflow | What it does | 做什么 |
|----|----------|-------------|--------|
| W4 | **PyMuPDF** | Annual report / patent full-text extraction, 500+ pages | 年报/专利全文提取，支持 500+ 页 |
| W5 | **Merge & Dedup** | Three-source dedup (DOI > title > title+year) | 三源文献去重合并 |
| W5b | **Annual Report Scraping** | A-share (Eastmoney) / HKEX / SEC EDGAR batch download | A股/港股/美股年报批量下载，4路径降级 |
| W6 | **Sogou Enterprise Search** | Chinese company news, industry dynamics via curl | 搜狗企业新闻/行业动态，curl 直连 |
| W7 | **Patent Search** | Google Patents CDP + CNKI patent database | 专利检索：技术路线/竞争格局 |
| W8 | **AI + Industry** | 7 sub-domains: materials · pharma · chemical · energy · agriculture · cosmetics · investment | AI+7大产业：材料/制药/化工/能源/农业/化妆品/投资 |

### Group 3: Investment & Strategy / 投资与战略组

| W# | Workflow | What it does | 做什么 |
|----|----------|-------------|--------|
| W9 | **Investment Research** | Financial data (AKShare) + SEC 10-K + competitor benchmarking | A股财务数据 + 美股 SEC + 竞品对标 |
| W10 | **Regulatory Search** | 10 regulators × 6 domain matrices (GB/T, ISO, FDA, EMA, NMPA…) | 10大监管机构 × 6领域法规矩阵 |
| W11 | **Supply Chain Mapping** | UN Comtrade API + upstream/midstream/downstream tree | 产业链映射：上中下游 + 关键卡点 |
| W12 | **Industrial Clusters** | 13 reference parks across 7 countries + policy incentives | 13个跨国化工园区速查 + 政策激励 |

---

## Domain Coverage / 领域覆盖 / Domänenabdeckung

10 industry dimensions, each with verified toolchain:

10 个产业维度，每个配备已验证工具链：

10 Industriedimensionen, jede mit verifizierter Werkzeugkette:

| Dimension / 维度 | Tools | Verified / 已验证 |
|------|------|:---:|
| 📚 Academic Literature | OpenAlex + GS + CNKI → 3-source dedup | ✅ 19 scenarios |
| 📄 Industrial PDFs | PyMuPDF → structured financials | ✅ 2 annual reports |
| 🏭 Market & Capacity | Sogou + annual reports + government sites | ✅ 3 enterprises |
| 🔬 Patents | Google Patents CDP + CNKI patent DB | ✅ W7 pipeline |
| 📏 Standards & Regulations | 10 regulatory bodies × 6 domain matrices | ✅ W10 pipeline |
| 🔗 Supply Chain | UN Comtrade + Sogou + annual reports | ✅ PU resin chain |
| 🤖 AI + Industry | 7 sub-branches (materials/pharma/energy/agri/cosmetics/investment/chemical) | ✅ W8 pipeline |
| 💰 Investment | AKShare + SEC EDGAR + HKEX CDP | ✅ 3 A-share companies |
| 🏗️ Industrial Clusters | 13 parks across 7 countries | ✅ W12 reference table |
| 🧬 Biopharma | Literature + process + AI + glycosylation + CDMO | ✅ 3 biopharma scenarios |

---

## Real-World Validations / 实战验证 / Praxisvalidierung

Every workflow validated against real data. Every workflow wurde gegen reale Daten validiert.

每个工作流均经过真实数据验证：

| # | Scenario / 场景 | Data / 数据 | Key Insight / 关键洞察 |
|---|------|:---:|------|
| 1 | PA11/PA1010 bio-based polyamide | 50 papers | 3-source lit review pipeline |
| 2 | Huafon Chemical annual report (241pp) | 458 KB | Full financial + capacity extraction |
| 5 | PHA industry panorama | 85 hits | Literature + market + degradation standards |
| 6 | AI + polymer materials design | 291 hits | Cross-domain ML frontier mapping |
| 11 | Biopharma industry panorama | 41 papers | CHO/purification/CGT/CDMO |
| 14 | Sogou enterprise search validation | 3 companies | Chinese enterprise news pipeline |
| 17 | Solid-state battery landscape | Lit + news | Academic + industry cross-validation |
| 18 | Alternative protein market | Academic + investment | Food tech multi-dimension |
| 19 | Active peptide cosmetics ingredients | Lit + enterprise | Cosmetics raw material pipeline |

Full 19 validated scenarios in [SKILL.md](SKILL.md).

完整 19 个验证场景详见 [SKILL.md](SKILL.md)。

---

## Traps & Pitfalls / 陷阱速查 / Fallen

53 documented traps across 16 categories — each with root cause and fix. Because industry research breaks in predictable ways.

53 个已编目陷阱（16 类），每个附带根因和修复方案。产业研究的坑，有人替你踩过了。

53 katalogisierte Fallen (16 Kategorien) mit Ursache und Lösung. Die Fallstricke der Industrieforschung sind vorhersehbar — und dokumentiert.

| Top traps / 高频陷阱 |
|------|
| `print()` Chinese → crash (write to UTF-8 file instead) |
| PS 5.1 breaks `[建议]` (use PS 7+) |
| CNKI + VPN = HTTP 418 (direct only) |
| AKShare column names drift between versions |
| Eastmoney PDF API returns empty (multi-path fallback) |
| Sogou CSS selector class variants |

Full catalog → [traps-catalog.md](references/traps-catalog.md)

---

## Installation / 安装 / Installation

### Prerequisites / 环境要求

| Component | Min | For |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF, akshare, secedgar |
| Node.js | 18+ | CDP browser control |
| PowerShell | 7+ (**not** 5.1) | Windows UTF-8 compatibility |
| Chrome | Latest | Remote debugging (`chrome://inspect`) |

### One command / 一键安装

```bash
bash <(curl -sL https://raw.githubusercontent.com/coeus-io/synthon/master/install.sh)
```

### Step by step / 分步安装

```bash
npx skills install github:coeus-io/synthon
npx skills install github:coeus-io/academic-search
python3 -m pip install PyMuPDF akshare secedgar defuddle requests
bash ~/.claude/skills/synthon/scripts/check-env.sh
```

---

## Network / 网络 / Netzwerk

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

## Related / 相关 / Verwandt

| Resource | Description |
|------|------|
| [academic-search](https://github.com/coeus-io/academic-search) | CDP infrastructure this skill builds on |
| [SKILL.md](SKILL.md) | Full skill definition & workflow reference |
| [traps-catalog.md](references/traps-catalog.md) | 53 documented traps (16 categories) |

---

## License / 许可证 / Lizenz

MIT — [LICENSE](LICENSE)

---

*synthon v0.3.0 · Built on academic-search · 化工 / 生物基 / 聚合物 / 生命科学*
