---
name: chemind
description: |
  Chemical / Bio-Based Materials / Polymer / Life Sciences Industry Multi-Dimensional Deep Research.
  Covering academic literature, patents, market data, production capacity, supply chains,
  standards/regulations, and AI-driven materials discovery. Now with biopharma/CGT dimension.
  Built on academic-search for CDP infrastructure.

  化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究 Claude Code Skill。
  覆盖学术文献、专利、市场数据、产能产量、产业链、标准法规与 AI 驱动材料发现。
  新增生命科学/生物制药/细胞基因治疗维度。Built on academic-search for CDP infrastructure.

  Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymer- / Biowissenschaften.
  Deckt Literatur, Patente, Marktdaten, Produktionskapazitäten, Lieferketten, Normen
  und KI-gestützte Materialentdeckung ab. Jetzt mit Biopharma/CGT-Dimension.

  Triggers / 触发词 / Auslöser:
  Chemical industry research, bio-based materials, polymer market, production capacity,
  supply chain analysis, materials patents, AI materials design, technology landscape,
  competitive analysis, annual reports, biopharma, biosimilars, mAb, ADC, CGT, CHO, CDMO
metadata:
  version: "0.2.0"
  depends-on: ["academic-search"]
---

# chemind

> **Chemical / Bio-Based Materials / Polymer / Life Sciences Industry Multi-Dimensional Deep Research Claude Code Skill**
>
> *化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymer- / Biowissenschaften*

---

Built on `academic-search` for CDP infrastructure. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery. Now with biopharma / CGT / biologics dimension.

基于 `academic-search` CDP 基础设施。超越文献——整合市场数据、专利、标准、产能产量、产业链与 AI 驱动材料发现。新增生物制药/CGT/生物工艺维度。

Auf `academic-search` für CDP-Infrastruktur aufgebaut. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten und KI-gestützte Materialentdeckung. Jetzt mit Biopharma / CGT / Biologics-Dimension.

---

## Preamble: Network Environment Detection / 网络环境检测 / Netzwerkumgebung

### Users in China / 国内用户 / Nutzer in China

| Source / Quelle / 源 | Access / Zugang / 访问 | Method / Methode / 方法 |
|--------|--------|--------|
| OpenAlex | ✅ Direct / Direkt / 直连 | `curl` REST API |
| CNKI 知网 | ✅ Direct (NO VPN!) / Direkt (KEIN VPN!) / 直连 | CDP browser |
| Google Scholar | ❌ VPN required / VPN erforderlich / 需 VPN | CDP + manual fallback |
| Overseas sites / Ausländische Seiten / 海外站 | ❌ VPN required / VPN erforderlich / 需 VPN | `curl --proxy socks5h://127.0.0.1:10808` |

**⚠️ CNKI must NOT use VPN / CNKI 禁止 VPN / CNKI darf KEIN VPN verwenden** — VPN triggers HTTP 418 anti-bot.

### International Users / 国际用户 / Internationale Nutzer

All sources directly accessible. / 所有源可直接访问。 / Alle Quellen direkt zugänglich.

---

## Quick Routing / 快速路由 / Schnellnavigation

```
User Request / 用户需求 / Benutzeranfrage
├─ "latest papers" / "最新论文" / "neueste Arbeiten" → W1: OpenAlex
├─ "high-citation reviews" / "高引综述" / "Hochzitierte Übersichten" → W2: GS CDP (VPN required / 需VPN)
├─ "CNKI" / "知网" / "CNKI" → W3: CNKI CDP (NO VPN! / 禁止VPN!)
├─ "annual report" / "年报" / "Geschäftsbericht" → W4: PyMuPDF + W5b: Batch Scraping
├─ "market" / "市场" / "Markt" → W6: Industry Intel
├─ "patents" / "专利" / "Patente" → W7: Patent Search
├─ "AI+materials" / "AI+材料" / "KI+Materialien" → W8: AI + Materials
├─ "biopharma" / "生物药" / "Biopharma" → W1 → W4 → W6 → merge
│   ├─ Upstream: CHO cell culture / cell line engineering / 上游: CHO细胞培养
│   ├─ Downstream: continuous-flow purification / virus clearance / 下游: 连续流纯化
│   ├─ AI: PINN hybrid modeling / digital twins / AI: PINN混合建模
│   ├─ Analytics: glycosylation / QbD / 分析: 糖基化/质量源于设计
│   └─ Industry: CDMO landscape / biosimilars / 产业: CDMO格局
└─ "industry panorama" / "产业全景" / "Branchenpanorama" → ALL → merge
```

---

## Workflow W1: OpenAlex API Search

No CDP required. No API key. No rate limit.
无 CDP / 无 API Key / 无速率限制。
Kein CDP erforderlich. Kein API-Schlüssel. Keine Ratenbegrenzung.

```bash
curl -s "https://api.openalex.org/works?filter=title_and_abstract.search:KEYWORD,publication_year:2023-2026&sort=cited_by_count:desc&per_page=20&select=id,doi,title,publication_date,cited_by_count,authorships,open_access" \
  -H "User-Agent: chemind/0.2.0 (mailto:your@email.com)" \
  -o /tmp/oa_results.json
```

**Traps / 陷阱 / Fallen**: OA-01 (only academic journals / 学术期刊限定 / nur akademische Zeitschriften), OA-02 (pre-2022 sparse / 2022前覆盖稀疏 / vor 2022 lückenhaft), OA-03 (100k/day limit / 100k/天限制 / 100k/Tag-Limit)

---

## Workflow W2: Google Scholar CDP Search

Requires CDP + VPN (China users). See [[scholar-chinese-citations]] for Chinese citation regex.
需 CDP + VPN（国内用户）。中文引用提取见 [[scholar-chinese-citations]]。
Erfordert CDP + VPN (China-Nutzer). Siehe [[scholar-chinese-citations]] für chinesische Zitations-Regex.

```bash
PROXY="http://127.0.0.1:3456"
T=$(curl -s "$PROXY/new?url=https://scholar.google.com/scholar?q=KEYWORD&as_ylo=2023&hl=en" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 3

curl -s -X POST "$PROXY/eval?target=$T" -d '
JSON.stringify(Array.from(document.querySelectorAll(".gs_r.gs_or.gs_scl")).map(el => ({
  allText: el.textContent.slice(0, 600)
})))' -o /tmp/gs_results.json

# Python parsing — matches both "Cited by X" and "被引用次数：X"
# Python解析 — 同时匹配 "Cited by X" 和 "被引用次数：X"
# Python-Parsing — erkennt sowohl "Cited by X" als auch "被引用次数：X"

curl -s "$PROXY/close?target=$T"
```

**Traps**: GS-01~04 (full-width colon / 全角冒号 / vollbreiter Doppelpunkt, `<a>` tag citations / `<a>` 标签引用 / `<a>`-Tag-Zitate, JS filter failure / JS filter 失效 / JS-Filter-Versagen, VPN IP blocked / VPN IP 被屏蔽 / VPN-IP blockiert)

---

## Workflow W3: CNKI CDP Search

**⚠️ NO VPN — direct connection only.** VPN triggers HTTP 418.
**⚠️ 禁止 VPN — 仅直连。** VPN 触发 HTTP 418。
**⚠️ KEIN VPN — nur Direktverbindung.** VPN löst HTTP 418 aus.

```bash
PROXY="http://127.0.0.1:3456"

# 1. HTTP homepage (avoid SSL CNKI-01) / HTTP 主页 (避免 SSL CNKI-01) / HTTP-Startseite (SSL CNKI-01 vermeiden)
CNKI=$(curl -s "$PROXY/new?url=http://www.cnki.net" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 5

# 2. location.href jump to KNS8 (don't use /navigate — CNKI-02) / location.href 跳转 KNS8 (不用 /navigate — CNKI-02)
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'location.href = "https://kns.cnki.net/kns8s/defaultresult/index?korder=SU&kw=URL_ENCODED_KEYWORD"' > /dev/null
sleep 8

# 3. Extract (KNS8 selectors, validated 2026-05) / 提取 (KNS8 选择器, 2026-05 验证) / Extrahieren (KNS8-Selektoren, validiert 2026-05)
curl -s -X POST "$PROXY/eval?target=$CNKI" -d '
JSON.stringify({
  totalCount: document.querySelector("#countPageDiv .countText")?.textContent?.trim(),
  papers: Array.from(document.querySelectorAll(".result-table-list tbody tr")).map(tr => ({
    title:   tr.querySelector("td.name a")?.textContent?.trim(),
    authors: tr.querySelector("td.author")?.textContent?.trim(),
    source:  tr.querySelector("td.source a")?.textContent?.trim(),
    date:    tr.querySelector("td.date")?.textContent?.trim(),
    cites:   tr.querySelector("td.quote a")?.textContent?.trim()
  }))
})' -o /tmp/cnki_results.json

curl -s "$PROXY/close?target=$CNKI"
```

**⚠️ Pagination trap / 翻页陷阱 / Paginierungsfalle**: `.page-next` may return page 1 results (KNS8 bug, 2026-05).

**Traps**: CNKI-01~08 (SSL, `/navigate`, CAPTCHA, URL encoding, 10-page limit, KNS8 search box, pagination failure, VPN triggers 418)

Reference / 参考 / Referenz: [[cnki-kns8-selectors]]

---

## Workflow W4: PyMuPDF Industrial PDF Extraction

Annual report / patent full-text extraction.
年报 / 专利全文提取。
Geschäftsbericht / Patent-Volltextextraktion.

```python
import fitz, tempfile, os

doc = fitz.open("report.pdf")
out = os.path.join(tempfile.gettempdir(), 'pdf_output.txt')

with open(out, 'w', encoding='utf-8') as f:
    for i in range(len(doc)):
        f.write(f'\n===== PAGE {i+1} =====\n')
        f.write(doc[i].get_text())
        f.flush()  # Memory safety for large PDFs / 大PDF内存安全 / Speichersicherheit

doc.close()
# NEVER print() Chinese — always write to UTF-8 file (PDF-01)
# 绝不 print() 中文 — 始终写 UTF-8 文件 (PDF-01)
# NIEMALS print() für Chinesisch — immer in UTF-8-Datei schreiben (PDF-01)
```

**Traps**: PDF-01 (no print / 禁止print / kein print), PDF-02 (no TOC in reports / 年报无TOC / kein TOC in Berichten), PDF-03 (500+ page OOM / 500+页OOM / 500+ Seiten OOM)

Reference / 参考 / Referenz: [[pymupdf-industrial]]

---

## Workflow W5: Multi-Source Merge & Dedup

Three-source dedup & merge. / 三源去重合并。 / Drei-Quellen-Deduplizierung.

See / 详见 / Siehe: [[merge-dedup]]

---

## Workflow W5b: Annual Report Batch Scraping / 年报批量爬取

Batch download & analysis of annual reports from A-share (CNinfo), HKEX, and SEC EDGAR.
A股(巨潮) / 港股(披露易) / 美股(SEC EDGAR) 年报批量下载与分析。

**Tool Selection / 工具选型:**

| Market / 市场 | Tool / 工具 | Notes / 说明 |
|------|----------|------|
| A-share / A股 | AKShare + CNinfo API | All A-share filings / 全A股公告 |
| HKEX / 港股 | ScrapeHKEX + Selenium | HKEX ESG reports + annual reports / 披露易报告 |
| US / ADR / 美股 | secedgar | SEC EDGAR 20-F / 10-K downloads |

**PyMuPDF full-text extraction** → See / 见 / Siehe: [[pymupdf-industrial]]
**Full manual** → See / 见 / Siehe: [[annual-report-scraping]]

---

## Validated Scenarios / 已验证场景 / Validierte Szenarien

| # | Scenario / 场景 / Szenario | Dimensions / 维度 / Dimensionen | Data / 数据量 / Daten |
|---|------|------|:---:|
| 1 | **PA11/PA1010 bio-based polyamide** three-source search | Literature / patents / supply chain / capacity | 50 papers |
| 2 | **Huafon Chemical 241-page annual report** PyMuPDF extraction | Industrial PDF / capacity / finance / supply chain | 458 KB |
| 3 | **RSC Lab on a Chip OA paper** (44c continuous flow) | Academic OA / microfluidics purification / smart DSP | 22 pp |
| 4 | **Frontiers CGT 4.0 OA paper** (4c) | Academic OA / CGT / automation sensors | 6 pp |
| 5 | **PHA polyhydroxyalkanoates** industry panorama | Literature / market / degradation standards / capacity | 85 hits |
| 6 | **AI + polymer materials design** frontier | Literature / ML methods / materials informatics / industry | 291 hits |
| 7 | **Bio-based materials industry panorama** 3D cross-analysis | 3 directions × 10 dimensions | 60 papers |
| 8 | **Google Scholar Chinese citation** extraction | "被引用次数：133" regex | Full-width colon Regex |
| 9 | **CNKI no-VPN direct CDP** pipeline | KNS8 selectors + SSL bypass + pagination | 140 hits |
| 10 | **Windows 11 UTF-8 permanent fix** | Python / PowerShell / Git Bash | Permanent fix |
| 11 | **Biopharma industry panorama** upstream+downstream+AI+CDMO | Literature / process / AI / glycosylation / CDMO landscape | 41 hits |
| 12 | **WuXi Biologics 263pp annual report** PyMuPDF | Industrial PDF / capacity / finance / CDMO landscape | 5-year financials |
| 13 | **Samsung Biologics financial verification** | Cross-market reports (HKEX/KRX) + Wikipedia | 2023-2024 |

### Four-Direction Validation Details / 四方向验证详情 / Details der vier Richtungen

```
Direction 1 / 方向1: PA11 Bio-Based Polyamide / PA11 生物基聚酰胺
  ├─ OpenAlex: 27 hits → 20 papers (2023-2026)
  ├─ Google Scholar CDP: 10 papers (cross-decade, max 133c)
  ├─ CNKI CDP: 140 hits → 20 papers (theses + CN journals)
  └─ Merged: 50 unique papers

Direction 2 / 方向2: PHA Polyhydroxyalkanoates / PHA 聚羟基脂肪酸酯
  ├─ OpenAlex: 85 hits → 15 TOP papers
  ├─ Topics: microbial production / extraction / biocomposites / food packaging / marine degradation
  └─ Capacity: Danimer ~30k t/a, Ningbo Tianan ~20k t/a, MicroGen ~10k t/a

Direction 3 / 方向3: AI + Polymer Materials / AI + 聚合物材料
  ├─ OpenAlex ×2: 269+22 hits → 25 TOP papers
  ├─ Topics: composite ML / membrane design ML / polymer inverse design / polymer informatics
  └─ Representatives: BASF/Dow/3M built in-house AI materials platforms

Direction 4 / 方向4: Biopharma / Bioprocess / 生物制药 / 生物工艺
  ├─ OpenAlex: 41 hits → 15 TOP papers (2023-2025)
  ├─ Upstream: CHO cell modeling (9c) / apoptosis-autophagy / MediaAssist culture medium DB
  ├─ Downstream: microfluidic continuous-flow (44c) / virus filtration (Planova) / CRISPR mycoplasma
  ├─ AI: PINN hybrid modeling (13c) / CGT 4.0 (4c) / deep learning SERS monitoring
  ├─ Analytics: N-glycan preparation techniques (13c) — biosimilar comparability key
  └─ Industry: global CDMO ~$200B, Lonza/WuXi/Samsung lead, ADC hottest track
```

---

## Traps Quick-Ref / 陷阱速查 / Fallen-Schnellreferenz

**30** cataloged traps across 7 categories.
**30** 个已知陷阱 (7类)。
**30** katalogisierte Fallen in 7 Kategorien.

| # | Trap / 陷阱 / Falle | Impact / 影响 / Auswirkung |
|---|------|------|
| 1 | `print()` Chinese → crash / 崩溃 / Absturz | All Python workflows |
| 2 | PS 5.1 instead of 7+ / PS 5.1 而非 7+ | `[建议]` parsed as array operator |
| 3 | CNKI + VPN → HTTP 418 | CNKI fully blocked |
| 4 | CDP `/navigate` for CNKI | URL params stripped |
| 5 | GS regex missing full-width colon | Misses all Chinese interface results |
| 6 | CNKI `.page-next` failure | Pagination silently fails |
| 7 | Google Scholar without VPN (China) | Site unreachable |

Full catalog / 完整目录 / Vollständiger Katalog: [[traps-catalog]]

---

## Dimensions Covered / 覆盖维度 / Abgedeckte Dimensionen

| Dimension / 维度 | Tools/Sources / 工具/源 / Werkzeuge/Quellen |
|------|------|
| 📚 Literature / 文献 / Literatur | OpenAlex + Google Scholar + CNKI (three-source dedup) |
| 📄 Industrial PDFs / 工业PDF / Industrielle PDFs | PyMuPDF (annual reports / patents) |
| 🏭 Market/Capacity / 市场/产能 / Markt/Kapazität | defuddle + WebSearch + CNKI |
| 🔬 Patents / 专利 / Patente | Google Patents + CNKI patent database |
| 📏 Standards/Regulations / 标准/法规 / Normen | GB/T, ISO, EU, China plastic ban, FDA/EMA |
| 🔗 Supply Chain / 产业链 / Lieferkette | Industry reports + trade associations + annual reports |
| 🤖 AI+Materials / AI+材料 / KI+Materialien | OpenAlex + GS (ML materials design) |
| 🧬 Biopharma / 生物制药 / Biopharma | OpenAlex + GS + CNKI (CHO/purification/AI/CGT/CDMO) |

---

## Reference Files / 参考文档 / Referenzdokumente

| File / 文件 / Datei | Content / 内容 / Inhalt |
|------|------|
| [[traps-catalog]] | 30 cataloged traps (7 categories) / 30个已知陷阱 / 30 Fallen |
| [[cnki-kns8-selectors]] | CNKI KNS8 DOM selectors / CNKI KNS8 DOM 选择器 / CNKI KNS8 DOM-Selektoren |
| [[scholar-chinese-citations]] | GS Chinese citation extraction / GS 中文引用提取 / GS Chinesische Zitationsextraktion |
| [[windows-utf8-fix]] | Windows UTF-8 permanent fix / Windows UTF-8 根治 / Windows UTF-8 permanente Lösung |
| [[pymupdf-industrial]] | PyMuPDF industrial PDF guide / PyMuPDF 工业 PDF 指南 / PyMuPDF Industrie-PDF-Anleitung |
| [[merge-dedup]] | Multi-source dedup & merge / 多源去重合并 / Multi-Quellen-Deduplizierung |
| [[annual-report-scraping]] | Annual report scraping (A-share/HKEX/US) / 上市公司报告爬取 / Geschäftsbericht-Scraping |

---

*chemind v0.2.0 · Built on academic-search · Validated on Windows 11*
*Chemical / Bio-Based / Polymer / Life Sciences Industry · 化工 / 生物基材料 / 聚合物 / 生命科学产业 · Chemie / Biobasierte Materialien / Polymer- / Biowissenschaften*
