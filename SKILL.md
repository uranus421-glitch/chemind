---
name: deep-chem
description: |
  化工 / 生物基材料 / 聚合物产业的多维度深度研究 Claude Code Skill。
  覆盖学术文献、专利、市场数据、产能产量、产业链、标准法规与 AI 驱动材料发现。
  Built on academic-search for CDP infrastructure.

  Chemical / Bio-Based Materials / Polymer Industry Multi-Dimensional Deep Research Claude Code Skill.
  Covering academic literature, patents, market data, production capacity, supply chains,
  standards/regulations, and AI-driven materials discovery. Built on academic-search.

  Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymerindustrie.
  Deckt wissenschaftliche Literatur, Patente, Marktdaten, Produktionskapazitäten,
  Lieferketten, Normen und KI-gestützte Materialentdeckung ab.

  触发词 / Triggers / Auslöser:
  化工产业研究、生物基材料、聚合物市场、产能产量、产业链分析、
  材料专利、AI材料设计、技术路线、竞争格局、上市公司年报
metadata:
  version: "0.2.0"
  depends-on: ["academic-search"]
---

# deep-chem

> **化工 / 生物基材料 / 聚合物产业的多维度深度研究 Claude Code Skill**
>
> *Chemical / Bio-Based Materials / Polymer Industry Multi-Dimensional Deep Research*
>
> *Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymerindustrie*

---

Built on `academic-search` for CDP infrastructure. Goes beyond literature — integrates market data, patents, standards, production capacity, supply chains, and AI-driven materials discovery.

Auf `academic-search` für CDP-Infrastruktur aufgebaut. Geht über Literatur hinaus — integriert Marktdaten, Patente, Normen, Produktionskapazitäten, Lieferketten und KI-gestützte Materialentdeckung.

---

## Preamble: Network Environment Detection / 网络环境检测 / Netzwerkumgebung

### 国内用户 / Users in China / Nutzer in China

| Source / 源 / Quelle | Access / 访问 / Zugang | Method / 方法 / Methode |
|--------|--------|--------|
| OpenAlex | ✅ 直连 / Direct / Direkt | `curl` REST API |
| CNKI 知网 | ✅ 直连 / Direct (NO VPN!) / Direkt (KEIN VPN!) | CDP browser |
| Google Scholar | ❌ 需 VPN / VPN required / VPN erforderlich | CDP + manual fallback |
| Overseas sites / 海外站 / Ausländische Seiten | ❌ 需 VPN / VPN required / VPN erforderlich | `curl --proxy socks5h://127.0.0.1:10808` |

**⚠️ CNKI 禁止 VPN / CNKI must NOT use VPN / CNKI darf KEIN VPN verwenden** — VPN triggers HTTP 418 anti-bot.

### 国际用户 / International Users / Internationale Nutzer

All sources directly accessible. / 所有源可直接访问。 / Alle Quellen direkt zugänglich.

---

## Quick Routing / 快速路由 / Schnellnavigation

```
用户需求 / User Request / Benutzeranfrage
├─ "最新论文" / "latest papers" / "neueste Arbeiten" → W1: OpenAlex
├─ "高引综述" / "high-citation reviews" / "Hochzitierte Übersichten" → W2: GS CDP (需VPN)
├─ "知网" / "CNKI" / "CNKI" → W3: CNKI CDP (禁止VPN!)
├─ "年报" / "annual report" / "Geschäftsbericht" → W4: PyMuPDF
├─ "市场" / "market" / "Markt" → W6: Industry Intel
├─ "专利" / "patents" / "Patente" → W7: Patent Search
├─ "AI+材料" / "AI+materials" / "KI+Materialien" → W8: AI + Materials
└─ "产业全景" / "industry panorama" / "Branchenpanorama" → ALL → merge
```

---

## Workflow W1: OpenAlex API Search

无 CDP / 无 API Key / 无速率限制。
No CDP required. No API key. No rate limit.
Kein CDP erforderlich. Kein API-Schlüssel. Keine Ratenbegrenzung.

```bash
curl -s "https://api.openalex.org/works?filter=title_and_abstract.search:KEYWORD,publication_year:2023-2026&sort=cited_by_count:desc&per_page=20&select=id,doi,title,publication_date,cited_by_count,authorships,open_access" \
  -H "User-Agent: deep-chem/0.2.0 (mailto:your@email.com)" \
  -o /tmp/oa_results.json
```

**Traps / 陷阱 / Fallen**: OA-01 (学术期刊限定 / only academic journals / nur akademische Zeitschriften), OA-02 (2022前覆盖稀疏 / pre-2022 sparse / vor 2022 lückenhaft), OA-03 (100k/天限制 / 100k/day limit / 100k/Tag-Limit)

---

## Workflow W2: Google Scholar CDP Search

需 CDP + VPN（国内用户）。中文引用提取见 [[scholar-chinese-citations]]。
Requires CDP + VPN (China users). See [[scholar-chinese-citations]] for Chinese citation regex.
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

# Python解析 — 同时匹配 "Cited by X" 和 "被引用次数：X"
# Python parsing — matches both "Cited by X" and "被引用次数：X"
# Python-Parsing — erkennt sowohl "Cited by X" als auch "被引用次数：X"

curl -s "$PROXY/close?target=$T"
```

**Traps**: GS-01~04 (全角冒号 / full-width colon / vollbreiter Doppelpunkt, `<a>` 标签引用 / `<a>` tag citations / `<a>`-Tag-Zitate, JS filter 失效 / JS filter failure / JS-Filter-Versagen, VPN IP 被屏蔽 / VPN IP blocked / VPN-IP blockiert)

---

## Workflow W3: CNKI 知网 CDP Search

**⚠️ 禁止 VPN — 仅直连。** VPN triggers HTTP 418。
**⚠️ NO VPN — direct connection only.** VPN löst HTTP 418 aus.
**⚠️ KEIN VPN — nur Direktverbindung.** VPN löst HTTP 418 aus.

```bash
PROXY="http://127.0.0.1:3456"

# 1. HTTP 主页 (避免 SSL CNKI-01) / HTTP homepage (avoid SSL CNKI-01) / HTTP-Startseite (SSL CNKI-01 vermeiden)
CNKI=$(curl -s "$PROXY/new?url=http://www.cnki.net" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 5

# 2. location.href 跳转 KNS8 (不用 /navigate — CNKI-02)
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'location.href = "https://kns.cnki.net/kns8s/defaultresult/index?korder=SU&kw=URL_ENCODED_KEYWORD"' > /dev/null
sleep 8

# 3. 提取 (KNS8 选择器, 2026-05 验证) / Extract (KNS8 selectors, validated 2026-05) / Extrahieren (KNS8-Selektoren, validiert 2026-05)
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

**⚠️ 翻页陷阱 / Pagination trap / Paginierungsfalle**: `.page-next` 可能返回第1页相同结果 (KNS8 bug, 2026-05)。

**Traps**: CNKI-01~08 (SSL, `/navigate`, CAPTCHA, URL编码, 10页限制, KNS8搜索框, 翻页失效, VPN触发418)

参考 / Reference / Referenz: [[cnki-kns8-selectors]]

---

## Workflow W4: PyMuPDF Industrial PDF Extraction

年报 / 专利全文提取。
Annual report / patent full-text extraction.
Geschäftsbericht / Patent-Volltextextraktion.

```python
import fitz, tempfile, os

doc = fitz.open("report.pdf")
out = os.path.join(tempfile.gettempdir(), 'pdf_output.txt')

with open(out, 'w', encoding='utf-8') as f:
    for i in range(len(doc)):
        f.write(f'\n===== PAGE {i+1} =====\n')
        f.write(doc[i].get_text())
        f.flush()  # 大PDF内存安全 / Memory safety / Speichersicherheit

doc.close()
# 绝不 print() 中文 — 始终写 UTF-8 文件 (PDF-01)
# NEVER print() Chinese — always write to UTF-8 file (PDF-01)
# NIEMALS print() für Chinesisch — immer in UTF-8-Datei schreiben (PDF-01)
```

**Traps**: PDF-01 (禁止print / no print / kein print), PDF-02 (年报无TOC / no TOC in reports / kein TOC in Berichten), PDF-03 (500+页OOM / 500+ page OOM / 500+ Seiten OOM)

参考 / Reference / Referenz: [[pymupdf-industrial]]

---

## Workflow W5: Multi-Source Merge & Dedup

三源去重合并。Three-source dedup & merge. Drei-Quellen-Deduplizierung.

详见 / See / Siehe: [[merge-dedup]]

---

## Validated Scenarios / 已验证场景 / Validierte Szenarien

| # | 场景 / Scenario / Szenario | 维度 / Dimensions / Dimensionen | 数据量 / Data / Daten |
|---|------|------|:---:|
| 1 | **PA11/PA1010 长碳链生物基聚酰胺** 三源检索 | 文献 / 专利预判 / 产业链 / 产能 | 50 篇 |
| 2 | **华峰化学 241 页年报** PyMuPDF 全量提取 | 工业 PDF / 产能 / 财务 / 供应链 | 458 KB 文本 |
| 3 | **PHA 聚羟基脂肪酸酯** 产业全景 | 文献 / 市场 / 降解标准 / 产能 / 生态竞争 | 85 篇命中 |
| 4 | **AI + 聚合物材料设计** 交叉前沿 | 文献 / ML方法 / 材料信息学 / 产业应用 | 291 篇命中 |
| 5 | **生物基材料产业全景** 三维交叉 | 3方向×10维度综合 | 60 篇精选 + 产能 + 标准 + TRL |
| 6 | **Google Scholar 中文引用提取** | "被引用次数：133" 正则 | 全角冒号 Regex |
| 7 | **CNKI 无 VPN 直连 CDP** | KNS8 选择器 + SSL绕过 + 翻页 | 140 条命中 |
| 8 | **Windows 11 UTF-8 编码根治** | Python / PowerShell / Git Bash | 永久修复 |

### 三方向验证详情 / Three-Direction Validation Details / Details der drei Richtungen

```
方向1: PA11 生物基聚酰胺
  ├─ OpenAlex: 27 hits → 20 篇 (2023-2026)
  ├─ Google Scholar CDP: 10 篇 (跨年代经典, 最高133c)
  ├─ CNKI CDP: 140 hits → 20 篇 (学位论文+中文期刊)
  └─ 合并: 50 篇唯一文献

方向2: PHA 聚羟基脂肪酸酯
  ├─ OpenAlex: 85 hits → 15 篇 TOP
  ├─ 方向: 微生物生产 / 提取工艺 / 生物复合 / 食品包装 / 海洋降解
  └─ 产能: Danimer ~3万吨/年, 宁波天安 ~2万吨/年, 微构工场 ~1万吨/年

方向3: AI + 聚合物材料
  ├─ OpenAlex ×2: 269+22 hits → 25 篇 TOP
  ├─ 方向: 复合材料ML / 膜设计ML / 高分子逆向设计 / 聚合物信息学
  └─ 代表: BASF/Dow/3M 自建AI材料平台
```

---

## Traps Quick-Ref / 陷阱速查 / Fallen-Schnellreferenz

共 **30** 个已知陷阱 (7类)。
**30** cataloged traps across 7 categories.
**30** katalogisierte Fallen in 7 Kategorien.

| # | 陷阱 / Trap / Falle | 影响 / Impact / Auswirkung |
|---|------|--------|
| 1 | `print()` 中文 → 崩溃 / crash / Absturz | 所有 Python 工作流 |
| 2 | PS 5.1 而非 7+ | `[建议]` 解析为数组操作符 |
| 3 | CNKI + VPN → HTTP 418 | CNKI 完全封锁 |
| 4 | CDP `/navigate` 用于 CNKI | URL 参数被截断 |
| 5 | GS 引用 Regex 无全角冒号 | 丢失所有中文界面结果 |
| 6 | CNKI `.page-next` 失效 | 翻页静默失败 |
| 7 | Google Scholar 无 VPN (国内) | 网站不可达 |

完整目录 / Full catalog / Vollständiger Katalog: [[traps-catalog]]

---

## 覆盖维度 / Dimensions Covered / Abgedeckte Dimensionen

| 维度 / Dimension | 工具/源 / Tools/Sources / Werkzeuge/Quellen |
|------|------|
| 📚 文献 / Literature / Literatur | OpenAlex + Google Scholar + CNKI (三源合并) |
| 📄 工业PDF / Industrial PDFs / Industrielle PDFs | PyMuPDF (年报/专利) |
| 🏭 市场/产能 / Market/Capacity / Markt/Kapazität | defuddle + WebSearch + CNKI |
| 🔬 专利 / Patents / Patente | Google Patents + CNKI 专利库 |
| 📏 标准/法规 / Standards / Normen | GB/T, ISO, EU, 中国限塑令 |
| 🔗 产业链 / Supply Chain / Lieferkette | 研报 + 行业协会 + 年报 |
| 🤖 AI+材料 / AI+Materials / KI+Materialien | OpenAlex + GS (ML材料设计) |

---

## Reference Files / 参考文档 / Referenzdokumente

| 文件 / File / Datei | 内容 / Content / Inhalt |
|------|------|
| [[traps-catalog]] | 30个已知陷阱 (7类) / 30 traps / 30 Fallen |
| [[cnki-kns8-selectors]] | CNKI KNS8 DOM 选择器 / selectors / Selektoren |
| [[scholar-chinese-citations]] | GS 中文引用提取 / Chinese citation extraction / Chinesische Zitationsextraktion |
| [[windows-utf8-fix]] | Windows UTF-8 根治 / permanent fix / permanente Lösung |
| [[pymupdf-industrial]] | PyMuPDF 工业 PDF 指南 / industrial PDF guide / Industrie-PDF-Anleitung |
| [[merge-dedup]] | 多源去重合并 / multi-source dedup / Multi-Quellen-Deduplizierung |

---

*deep-chem v0.2.0 · Built on academic-search · Validated on Windows 11*
*化工 / 生物基材料 / 聚合物产业 · Chemical / Bio-Based / Polymer Industry · Chemie / Biobasierte Materialien / Polymerindustrie*
