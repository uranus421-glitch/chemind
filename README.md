# deep-chem

> **化工 / 生物基材料 / 聚合物产业的多维度深度研究 Claude Code Skill**
>
> *Chemical / Bio-Based Materials / Polymer Industry Multi-Dimensional Deep Research*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymerindustrie*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

---

## 定位 / Positioning / Positionierung

`deep-chem` 是 `academic-search` 的**化工材料产业增强层**。不止于文献——整合市场数据、专利、标准、产能产量、产业链与 AI 驱动材料发现。

`deep-chem` is the **chemical/materials industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery.

`deep-chem` ist die **Erweiterungsschicht für die chemische/materialbasierte Industrie** auf Basis von `academic-search`. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten und KI-gestützte Materialentdeckung.

---

## 覆盖维度 / Dimensions / Abgedeckte Dimensionen

| 维度 Dimension | 工具/源 Tools/Quellen | 
|------|------|
| 📚 学术文献 Academic Literature / Wissenschaftliche Literatur | OpenAlex + Google Scholar + CNKI |
| 📄 工业 PDF Industrial PDFs / Industrielle PDFs | PyMuPDF (年报/专利) |
| 🏭 市场/产能 Market/Capacity / Markt/Kapazität | defuddle + WebSearch + CNKI |
| 🔬 专利 Patents / Patente | Google Patents + CNKI 专利库 |
| 📏 标准/法规 Standards / Normen | GB/T, ISO, EU, 限塑令 |
| 🔗 产业链 Supply Chain / Lieferkette | 研报 + 行业协会 + 年报 |
| 🤖 AI+材料 AI+Materials / KI+Materialien | OpenAlex + GS (ML材料设计) |

---

## 快速开始 / Quick Start / Schnellstart

```bash
npx skills install github:uranus421-glitch/deep-chem
bash scripts/check-env.sh        # 环境检查 / Environment check / Umgebungsprüfung
pip install PyMuPDF              # Python 依赖 / Python dependency / Python-Abhängigkeit
npx skills install github:uranus421-glitch/academic-search
```

---

## 触发词 / Triggers / Auslöser

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报

Chemical industry research · bio-based materials · polymer market · production capacity · supply chain · technology landscape · patents · AI materials design · annual reports

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkette · Technologielandschaft · Patente · KI-Materialdesign · Geschäftsberichte

---

## 8 个工作流 / 8 Workflows / 8 Arbeitsabläufe

| W# | 名称 / Name | 源 / Source / Quelle | 维度 / Dimension |
|----|------|--------|----------|
| W1 | OpenAlex | REST API | 2023+ 最新论文 / Latest papers / Neueste Arbeiten |
| W2 | Google Scholar CDP | CDP Browser (需VPN) | 跨年代高引综述 / High-citation reviews / Hochzitierte Übersichten |
| W3 | CNKI 知网 CDP | CDP Browser (禁止VPN!) | 中文全量+学位论文 / Chinese full-text+theses / Chinesischer Volltext |
| W4 | PyMuPDF | PDF Parser | 年报/专利全文 / Annual reports/patents / Geschäftsberichte/Patente |
| W5 | 多源合并去重 | Python | 三源去重 / Three-source dedup / Drei-Quellen-Deduplizierung |
| W6 | 产业情报 | defuddle+scrapling | 市场/产能/产业链 / Market/capacity/supply chain / Markt/Kapazität/Lieferkette |
| W7 | 专利检索 | Google Patents+CNKI | 技术路线/竞争格局 / Technology landscape / Technologielandschaft |
| W8 | AI+材料 | OpenAlex+GS | ML材料设计 / ML materials design / KI-Materialdesign |

---

## 已验证场景 / Validated Scenarios / Validierte Szenarien

| # | 场景 Scenario Szenario | 维度 | 数据量 |
|---|------|------|:---:|
| 1 | PA11/PA1010 长碳链生物基聚酰胺 三源检索 | 文献/专利预判/产业链/产能 | 50篇 |
| 2 | 华峰化学 241页年报 PyMuPDF 全量提取 | 工业PDF/产能/财务/供应链 | 458KB |
| 3 | PHA 聚羟基脂肪酸酯 产业全景 | 文献/市场/降解标准/产能/生态竞争 | 85篇命中 |
| 4 | AI + 聚合物材料设计 交叉前沿 | 文献/ML方法/材料信息学/产业应用 | 291篇命中 |
| 5 | 生物基材料产业全景 三维交叉 | 3方向×10维度综合 | 60篇精选+产能+标准+TRL |
| 6 | Google Scholar 中文引用提取 | "被引用次数：133" 正则 | 全角冒号Regex |
| 7 | CNKI 无VPN直连 CDP | KNS8选择器+SSL绕过 | 140条命中 |
| 8 | Windows 11 UTF-8 编码根治 | Python/PowerShell/Git Bash | 永久修复 |

---

## 已知陷阱 / Known Traps / Bekannte Fallen

**30 个已编目陷阱** (7 类)。详见 [[traps-catalog]]。

**30 cataloged traps** (7 categories). See [[traps-catalog]].

**30 katalogisierte Fallen** (7 Kategorien). Siehe [[traps-catalog]].

| 最致命 Top Fatal / Tödlichste |
|---|
| 1. `print()` 中文→崩溃 / crash / Absturz |
| 2. PS 5.1 而非 7+ → 编码错误 |
| 3. CNKI+VPN → HTTP 418 封锁 |
| 4. CDP `/navigate` → URL参数截断 |
| 5. GS Regex 无全角冒号 → 丢失中文引用 |
| 6. CNKI `.page-next` → 翻页静默失败 |
| 7. GS 无VPN(国内) → 网站不可达 |

---

## 网络说明 / Network Notes / Netzwerk-Hinweise

- **CNKI 知网**：必须直连，VPN 触发 HTTP 418 / MUST use direct connection, VPN triggers HTTP 418 / MUSS Direktverbindung nutzen, VPN löst HTTP 418 aus
- **Google Scholar** (国内/China)：需 VPN — `socks5h://127.0.0.1:10808`
- **国际用户 / International / International**：所有源可直接访问 / All sources directly accessible / Alle Quellen direkt zugänglich

---

## 许可证 / License / Lizenz

MIT — [LICENSE](LICENSE)

---

*deep-chem v0.2.0 · 化工/生物基/聚合物 · Chemical/Bio-Based/Polymer · Chemie/Biobasiert/Polymere*
