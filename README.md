# deep-chem

> **化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究 Claude Code Skill**
>
> *Chemical / Bio-Based Materials / Polymer / Life Sciences Industry Multi-Dimensional Deep Research*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymer- / Biowissenschaften*

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

---

## 定位 / Positioning / Positionierung

`deep-chem` 是 `academic-search` 的**化工材料与生命科学产业增强层**。不止于文献——整合市场数据、专利、标准、产能产量、产业链与 AI 驱动材料发现。新增生物制药/CGT/生物工艺维度。

`deep-chem` is the **chemical/materials & life sciences industry enhancement layer** on top of `academic-search`. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery. Now with biopharma/CGT/bioprocess dimension.

`deep-chem` ist die **Erweiterungsschicht für die chemische/materialbasierte Industrie & Biowissenschaften** auf Basis von `academic-search`. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten und KI-gestützte Materialentdeckung. Jetzt mit Biopharma/CGT/Bioprozess-Dimension.

---

## 覆盖维度 / Dimensions / Abgedeckte Dimensionen

| 维度 Dimension | 工具/源 Tools/Quellen | 
|------|------|
| 📚 学术文献 Academic Literature / Wissenschaftliche Literatur | OpenAlex + Google Scholar + CNKI |
| 📄 工业 PDF Industrial PDFs / Industrielle PDFs | PyMuPDF (年报/专利) |
| 🏭 市场/产能 Market/Capacity / Markt/Kapazität | defuddle + WebSearch + CNKI |
| 🔬 专利 Patents / Patente | Google Patents + CNKI 专利库 |
| 📏 标准/法规 Standards / Normen | GB/T, ISO, EU, 限塑令, FDA/EMA |
| 🔗 产业链 Supply Chain / Lieferkette | 研报 + 行业协会 + 年报 |
| 🤖 AI+材料 AI+Materials / KI+Materialien | OpenAlex + GS (ML材料设计) |
| 🧬 生物制药 Biopharma / Biopharma | OpenAlex + GS + CNKI (CHO/纯化/AI/CGT/CDMO) |

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

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报 · 生物制药 · 生物类似药 · 单抗 · ADC · 细胞基因治疗 · CHO培养 · CDMO

Chemical industry research · bio-based materials · polymer market · production capacity · supply chain · technology landscape · patents · AI materials design · annual reports · biopharma · biologics · mAb · ADC · CGT · CHO culture · CDMO

Chemieindustrieforschung · biobasierte Materialien · Polymermarkt · Produktionskapazität · Lieferkette · Technologielandschaft · Patente · KI-Materialdesign · Geschäftsberichte · Biopharma · Biologics · mAb · ADC · CGT · CHO-Kultur · CDMO

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
| 3 | RSC Lab on a Chip OA论文 PyMuPDF (44c 连续流) | 学术OA PDF/微流控纯化/智能下游 | 22页 4.1MB |
| 4 | Frontiers CGT 4.0 OA论文 PyMuPDF (4c) | 学术OA PDF/CGT/自动化传感器 | 6页 854KB |
| 5 | PHA 聚羟基脂肪酸酯 产业全景 | 文献/市场/降解标准/产能/生态竞争 | 85篇命中 |
| 6 | AI + 聚合物材料设计 交叉前沿 | 文献/ML方法/材料信息学/产业应用 | 291篇命中 |
| 7 | 生物基材料产业全景 三维交叉 | 3方向×10维度综合 | 60篇精选+产能+标准+TRL |
| 8 | Google Scholar 中文引用提取 | "被引用次数：133" 正则 | 全角冒号Regex |
| 9 | CNKI 无VPN直连 CDP | KNS8选择器+SSL绕过 | 140条命中 |
| 10 | Windows 11 UTF-8 编码根治 | Python/PowerShell/Git Bash | 永久修复 |
| 11 | 生物制药产业全景 上游+下游+AI+CDMO | 文献/工艺/AI/糖基化/竞争格局 | 41篇命中/TOP15 |

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

*deep-chem v0.2.0 · 化工/生物基/聚合物/生命科学 · Chemical/Bio-Based/Polymer/Life Sciences · Chemie/Biobasiert/Polymere/Biowissenschaften*
