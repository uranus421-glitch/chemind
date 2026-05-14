---
name: deep-chem
description: |
  化工与生物基材料产业深度研究 Skill。Multi-dimensional industry research
  covering: academic literature, patents, market data, production capacity,
  supply chain, standards, and AI-driven materials discovery. Built on
  academic-search for CDP infrastructure. Triggers: 化工产业研究、生物基材料、
  聚合物市场、产能产量、产业链分析、材料专利、AI材料设计、技术路线、
  竞争格局、上市公司年报.
metadata:
  version: "0.2.0"
  depends-on: ["academic-search"]
---

# deep-chem — 化工与生物基材料产业深度研究

> Multi-dimensional chemical/bio-based materials industry research.
> Built on `academic-search` for CDP infrastructure. Goes beyond literature —
> integrates market data, patents, standards, production capacity, supply chains,
> and AI-driven materials discovery.

## Preamble: Network Environment Detection

### If user is in China (国内)

| Source | Access | Method |
|--------|--------|--------|
| OpenAlex | ✅ Direct | `curl` REST API |
| CNKI 知网 | ✅ Direct (NO VPN!) | CDP browser |
| Google Scholar | ❌ VPN required | CDP + manual browser fallback |
| Overseas sites | ❌ VPN required | `curl --proxy socks5h://127.0.0.1:10808` |

**⚠️ CNKI must NOT use VPN** — VPN triggers HTTP 418 anti-bot blocking.
**⚠️ Google Scholar and overseas sites need VPN** — `socks5h://127.0.0.1:10808`.

### If user is outside China (国际)

All sources directly accessible. CNKI may be slower but no VPN needed.

---

## Quick Routing (30-Second Decision Tree)

```
User request
├─ "最新论文" / "英文文献" → W1: OpenAlex
├─ "高引综述" / "引用数" → W2: Google Scholar CDP (需VPN)
├─ "知网" / "中文文献" / "学位论文" → W3: CNKI CDP (禁止VPN!)
├─ "年报" / "专利PDF" → W4: PyMuPDF
├─ "市场数据" / "产能" / "产业链" → W6: Industry Intel (scrapling + defuddle)
├─ "专利检索" / "技术路线" → W7: Patent Search
├─ "AI+材料" / "机器学习" → W8: AI + Materials
├─ "产业全景" / "技术综述" → ALL W1→W2→W3→W6→merge
└─ "编码错误" / "乱码" → Reference: windows-utf8-fix
```

---

## Workflow W1: OpenAlex API Search

No CDP required. No API key. No rate limit.

```bash
curl -s "https://api.openalex.org/works?filter=title_and_abstract.search:KEYWORD,publication_year:2023-2026&sort=cited_by_count:desc&per_page=20&select=id,doi,title,publication_date,cited_by_count,authorships,open_access" \
  -H "User-Agent: deep-chem/0.2.0 (mailto:your@email.com)" \
  -o /tmp/oa_results.json
```

| Param | Example | Notes |
|-------|---------|-------|
| `filter` | `title_and_abstract.search:KEYWORD` | Space-separated |
| `publication_year` | `2024-2026` | Pre-2022 sparse (OA-02) |
| `sort` | `cited_by_count:desc` | Also: `publication_date:desc` |
| `select` | `id,doi,title,...` | Minimize payload |

**Traps**: OA-01 (only academic journals), OA-02 (pre-2022 sparse), OA-03 (100k/day limit)

---

## Workflow W2: Google Scholar CDP Search

Requires CDP + VPN (China users). See [[scholar-chinese-citations]] for Chinese citation regex.

```bash
PROXY="http://127.0.0.1:3456"
T=$(curl -s "$PROXY/new?url=https://scholar.google.com/scholar?q=KEYWORD&as_ylo=2023&hl=en" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 3

curl -s -X POST "$PROXY/eval?target=$T" -d '
JSON.stringify(Array.from(document.querySelectorAll(".gs_r.gs_or.gs_scl")).map(el => ({
  allText: el.textContent.slice(0, 600)
})))' -o /tmp/gs_results.json

# Parse in Python — regex handles both "Cited by X" and "被引用次数：X"
python3 -c "
import json, re
with open('/tmp/gs_results.json', 'r') as f:
    data = json.load(f)
for item in json.loads(data['value']):
    cite = re.search(r'被引用次数[：:]\s*(\d+)|Cited by (\d+)', item['allText'])
    print(f'[{(cite.group(1) or cite.group(2)) if cite else 0}c] ...')
"

curl -s "$PROXY/close?target=$T"
```

**Traps**: GS-01~04 (Chinese colons, `<a>` tag citations, JS filter failure, VPN IP block)

---

## Workflow W3: CNKI 知网 CDP Search

**⚠️ NO VPN — direct connection only.** VPN triggers HTTP 418.

```bash
PROXY="http://127.0.0.1:3456"

# 1. Open via HTTP (avoids SSL CNKI-01)
CNKI=$(curl -s "$PROXY/new?url=http://www.cnki.net" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 5

# 2. Navigate to KNS8 (location.href, not /navigate — CNKI-02)
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'location.href = "https://kns.cnki.net/kns8s/defaultresult/index?korder=SU&kw=URL_ENCODED_KEYWORD"' > /dev/null
sleep 8

# 3. Extract (KNS8 selectors, validated 2026-05)
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

**⚠️ Pagination trap**: `.page-next` may return page 1 results. Known KNS8 bug (2026-05).

**Traps**: CNKI-01~06 (SSL, `/navigate`, CAPTCHA, URL encoding, 10-page limit, KNS8 search box)

Full reference: [[cnki-kns8-selectors]]

---

## Workflow W4: PyMuPDF Industrial PDF Extraction

```python
import fitz, tempfile, os

doc = fitz.open("report.pdf")
out = os.path.join(tempfile.gettempdir(), 'pdf_output.txt')

with open(out, 'w', encoding='utf-8') as f:
    for i in range(len(doc)):
        f.write(f'\n===== PAGE {i+1} =====\n')
        f.write(doc[i].get_text())
        f.flush()  # Memory safety for large PDFs

doc.close()
# NEVER print() Chinese — always write to UTF-8 file (PDF-01)
```

**Traps**: PDF-01 (no print), PDF-02 (no TOC in annual reports), PDF-03 (OOM on 500+ pages)

Full guide: [[pymupdf-industrial]]

---

## Workflow W5: Multi-Source Merge & Dedup

```python
# Dedup: DOI > title[:80] > title+year
all_papers, seen = [], set()
for paper in sources:
    key = paper.get('doi') or paper['title'][:80].lower()
    if key not in seen:
        seen.add(key); all_papers.append(paper)
all_papers.sort(key=lambda p: p.get('cites', 0), reverse=True)
```

Full implementation: [[merge-dedup]]

---

## Workflow W6: Industry Intelligence (NEW in v0.2)

For market data, production capacity, supply chain, industry news.

```bash
# Use defuddle for industry news (Chinese sites)
defuddle parse <url> --md

# Use scrapling-web-research for Reddit/HN/ProductHunt
# Use WebSearch for market reports, capacity data
```

### Industry Data Sources

| Type | Source | Method |
|------|--------|--------|
| 产能/产量 | 上市公司年报, 行业协会 | W4 PyMuPDF + CNKI |
| 市场价格 | 生意社, 卓创资讯 | defuddle |
| 产业链 | 券商研报, 行业白皮书 | WebSearch + CNKI |
| 标准/法规 | 国家标准网, ISO | WebSearch |
| 竞争格局 | 年报 + 行业新闻 | defuddle + scrapling |

---

## Workflow W7: Patent Search (NEW in v0.2)

```bash
# Google Patents (VPN required in China)
# Or CNKI 专利 database in KNS8 (dbcode=SCOD)
```

---

## Workflow W8: AI + Materials (NEW in v0.2)

For ML-driven polymer design, property prediction, materials informatics.

```bash
# OpenAlex with AI/ML keywords
curl -s "https://api.openalex.org/works?filter=title_and_abstract.search:polymer+machine+learning+property+prediction,publication_year:2023-2026&sort=cited_by_count:desc&per_page=20&select=id,doi,title,publication_date,cited_by_count,open_access"
```

---

## Traps Quick-Ref (Top 7 Most Fatal)

| # | Trap | Impact |
|---|------|--------|
| 1 | `print()` Chinese → crash | All Python workflows fail |
| 2 | PS 5.1 instead of 7+ | `[建议]` parsed as array operator |
| 3 | CNKI with VPN → HTTP 418 | CNKI entirely blocked |
| 4 | CDP `/navigate` for CNKI | URL params stripped |
| 5 | GS citation regex without full-width colon | Misses Chinese-interface results |
| 6 | CNKI `.page-next` stale results | Pagination silently fails |
| 7 | Google Scholar without VPN (China) | Site unreachable |

Full catalog: [[traps-catalog]] (28 traps across 7 categories)

---

## Environment Requirements

| Item | Min Version | Notes |
|------|-----------|-------|
| Python | 3.10+ | PyMuPDF + merge scripts |
| Node.js | 22+ | CDP proxy |
| Chrome | Any recent | Remote debugging enabled |
| PowerShell | **7+ (NOT 5.1)** | PS 5.1 UTF-8 bug |
| PyMuPDF | 1.24+ | `pip install PyMuPDF` |
| academic-search | latest | `npx skills install github:uranus421-glitch/academic-search` |

Run `bash scripts/check-env.sh` to verify.

---

## Reference Files

| File | Content |
|------|---------|
| [[traps-catalog]] | 28 known traps (7 categories) |
| [[cnki-kns8-selectors]] | CNKI KNS8 DOM selectors (2026-05) |
| [[scholar-chinese-citations]] | GS Chinese citation regex |
| [[windows-utf8-fix]] | Windows UTF-8 permanent fix |
| [[pymupdf-industrial]] | PyMuPDF annual report/patent extraction |
| [[merge-dedup]] | Multi-source dedup Python code |

---

*deep-chem v0.2.0 | Built on academic-search | Validated on Windows 11*
