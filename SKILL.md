---
name: deep-lit
description: |
  化工材料产业文献深度研究专用 Skill。Use when the user asks to search
  industrial/chemical/materials literature, do industry research on polymers/
  bio-based materials/chemical engineering, find Chinese papers on CNKI,
  extract annual reports or patents with PyMuPDF, or merge bilingual
  (Chinese+English) multi-source search results. Built on top of academic-search
  for CDP infrastructure. 触发词：产业研究、文献调研、知网、年报提取、材料搜索。
metadata:
  version: "0.1.0"
  depends-on: ["academic-search"]
---

# deep-lit — 化工材料产业文献深度研究

> Built on `academic-search` for CDP infrastructure. Adds chemical/materials domain knowledge,
> Chinese literature workflows (CNKI KNS8), industrial PDF extraction (PyMuPDF),
> and Windows UTF-8 fixes validated in production.

## Preamble: Network Environment Detection

Before running any workflow, determine the user's network environment:

### If user is in China (国内)

| Source | Access | Method |
|--------|--------|--------|
| OpenAlex | ✅ Direct | `curl` REST API |
| CNKI 知网 | ✅ Direct | CDP browser |
| Google Scholar | ❌ VPN required | CDP + manual browser fallback |
| Overseas publisher PDFs | ❌ VPN required | `curl --proxy socks5h://127.0.0.1:10808` |

**VPN prompt**: "⚠️ 此任务需要访问 Google Scholar 和海外学术资源。请开启 VPN 后告诉我，我继续执行检索。"

### If user is outside China (国际)

| Source | Access | Method |
|--------|--------|--------|
| OpenAlex | ✅ Direct | `curl` |
| Google Scholar | ✅ Direct | CDP |
| CNKI | ⚠️ May be slower | CDP (no VPN needed) |
| Overseas PDFs | ✅ Direct | `curl` / OA download |

Skip VPN prompt. All sources accessible directly.

---

## Quick Routing (30-Second Decision Tree)

```
User request
├─ "最新论文" / "英文文献" → Workflow W1: OpenAlex
├─ "高引综述" / "引用数" / "经典文献" → Workflow W2: Google Scholar CDP
├─ "知网" / "中文文献" / "学位论文" → Workflow W3: CNKI 知网 CDP
├─ "年报" / "专利PDF" / "提取全文" → Workflow W4: PyMuPDF
├─ "合并" / "去重" → Reference: merge-dedup
├─ "文献调研" / "产业研究" / "技术综述" → ALL W1→W2→W3→merge
└─ "编码错误" / "乱码" → Reference: windows-utf8-fix
```

---

## Workflow W1: OpenAlex API Search

No CDP required. No API key. No rate limit (polite use: 10 req/s).

### Basic Search

```bash
curl -s "https://api.openalex.org/works?filter=title_and_abstract.search:PA11+bio-based+polyamide,publication_year:2024-2026&sort=cited_by_count:desc&per_page=15&select=id,doi,title,publication_date,cited_by_count,authorships,open_access" \
  -H "User-Agent: deep-lit/0.1.0 (mailto:your@email.com)" \
  -o results.json
```

### Key Parameters

| Param | Example | Notes |
|-------|---------|-------|
| `filter` | `title_and_abstract.search:KEYWORD` | Space-separated keywords |
| `publication_year` | `2024-2026` | Year range. Pre-2022 coverage is sparse (trap OA-02) |
| `sort` | `cited_by_count:desc` | Also: `publication_date:desc`, `relevance` |
| `per_page` | `15` | Max 200 |
| `select` | `id,doi,title,...` | Minimize payload size |
| `open_access` | (in select) | Returns `is_oa`, `oa_url` fields |

### Parsing

```bash
python3 -c "
import json
with open('results.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
for w in data.get('results', []):
    oa = w.get('open_access', {})
    print(f'[{w.get(\"cited_by_count\",0)}c] ({w.get(\"publication_date\",\"?\")[:4]}) {w.get(\"title\",\"?\")}')
    if oa.get('is_oa'):
        print(f'  OA: {oa.get(\"oa_url\",\"?\")}')
" results.json
```

### Traps
- **OA-01**: Only academic journals — no industry reports or patents
- **OA-02**: Pre-2022 coverage is sparse
- **OA-03**: 100k/day rate limit

---

## Workflow W2: Google Scholar CDP Search

Requires CDP proxy from `academic-search`. VPN for users in China.

### Prerequisite: CDP Startup

```bash
# 1. Open chrome://inspect/#remote-debugging in Chrome → check the box
# 2. Start/verify CDP
bash ~/.claude/skills/academic-search/scripts/check-deps.sh
# Expected: chrome: ok (port 9222) | proxy: ready (port 3456)

# 3. Verify health
curl -s "http://127.0.0.1:3456/health"
```

### Search & Extract

```bash
PROXY="http://127.0.0.1:3456"

# 1. Create tab + search (add &hl=en for English interface)
T=$(curl -s "$PROXY/new?url=https://scholar.google.com/scholar?q=PA11+bio-based+polyamide&as_ylo=2023&as_yhi=2026&hl=en" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 3

# 2. Extract results — get raw textContent, filter in Python
curl -s -X POST "$PROXY/eval?target=$T" -d '
JSON.stringify(Array.from(document.querySelectorAll(".gs_r.gs_or.gs_scl")).map(el => ({
  allText: el.textContent.slice(0, 600)
})))
' -o scholar_results.json

# 3. Parse with Python (regex handles both "Cited by X" and "被引用次数：X")
python3 -c "
import json, re
with open('scholar_results.json', 'r', encoding='utf-8') as f:
    data = json.load(f)
items = json.loads(data['value'])
for item in items:
    text = item.get('allText', '')
    cite = re.search(r'被引用次数[：:]\s*(\d+)|Cited by (\d+)', text)
    cites = int(cite.group(1) or cite.group(2)) if cite else 0
    year = re.search(r'\b(20\d{2})\b', text)
    print(f'[{cites}c] ({year.group(1) if year else \"?\"}) {text[:100]}...')
"

# 4. Close tab
curl -s "$PROXY/close?target=$T"
```

### Traps
- **GS-01**: Chinese interface returns `被引用次数：133` (full-width colon)
- **GS-02**: Citation count is in `<a>` tag, NOT `.gs_fl` text
- **GS-03**: Don't filter in CDP eval — do it in Python
- **GS-04**: VPN exit IP may get blocked (403) — fall back to user manual browser search

See [[scholar-chinese-citations]] for detailed regex patterns.

---

## Workflow W3: CNKI 知网 CDP Search

Requires CDP proxy. Direct access for China users; may be slower internationally.

### Search Flow

```bash
PROXY="http://127.0.0.1:3456"

# 1. Open CNKI via HTTP (avoids SSL cert error CNKI-01)
CNKI=$(curl -s "$PROXY/new?url=http://www.cnki.net" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 4

# 2. Navigate to KNS8 results page via location.href (avoids CNKI-02)
#    Chinese keywords MUST be URL-encoded (CNKI-04)
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'location.href = "https://kns.cnki.net/kns8s/defaultresult/index?korder=SU&kw=%E5%B0%BC%E9%BE%991010"' > /dev/null
sleep 6

# 3. Check for CAPTCHA (CNKI-03)
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'document.body?.innerText?.includes("验证")' -o captcha_check.json

# If CAPTCHA → ask user to solve in browser window

# 4. Extract results (KNS8 selectors, validated 2026-05)
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
})
' -o cnki_results.json

# 5. Pagination (max 10 pages, 3-5s delay — CNKI-05)
# Repeat for pages 2-10:
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'document.querySelector(".page-next")?.click()' > /dev/null
sleep 3
# ... re-extract ...

# 6. Close tab
curl -s "$PROXY/close?target=$CNKI"
```

### KNS8 Selectors Quick-Ref

| Field | Selector |
|-------|----------|
| Title | `td.name a` |
| Authors | `td.author` |
| Source | `td.source a` |
| Date | `td.date` |
| Cites | `td.quote a` |
| Total count | `#countPageDiv .countText` |
| Next page | `.page-next` |

### Traps
- **CNKI-01**: SSL cert error → HTTP homepage + location.href jump
- **CNKI-02**: `/navigate` drops URL params → use `location.href`
- **CNKI-03**: CAPTCHA → user solves in browser (shared session)
- **CNKI-04**: Chinese keywords → must URL-encode for curl
- **CNKI-05**: 10-page limit with 3-5s delay
- **CNKI-06**: Homepage search box is a custom component → skip, use KNS8 URL directly

Full selector reference: [[cnki-kns8-selectors]]

---

## Workflow W4: PyMuPDF Industrial PDF Extraction

For annual reports (年报), patents, and non-academic PDFs.

### Standard Template

```python
import fitz
import tempfile
import os

pdf_path = "annual_report.pdf"
doc = fitz.open(pdf_path)

# NEVER print() Chinese — always write to UTF-8 file
out_path = os.path.join(tempfile.gettempdir(), 'pdf_output.txt')
with open(out_path, 'w', encoding='utf-8') as f:
    for i in range(len(doc)):
        text = doc[i].get_text()
        f.write(f'\n===== PAGE {i+1} =====\n')
        f.write(text)

doc.close()
print(f"Done: {len(doc)} pages → {out_path}")
```

### Performance

| Type | Pages | Output | Time |
|------|-------|--------|------|
| Annual report | 241 | ~458 KB | < 10s |
| Academic paper | 12 | ~45 KB | < 1s |
| Patent | 30-80 | ~120 KB | 2-5s |

### Traps
- **PDF-01**: Never `print()` Chinese — UnicodeEncodeError
- **PDF-02**: Annual reports lack TOC (`doc.get_toc()` returns `[]`)
- **PDF-03**: Large PDFs → write page-by-page, don't accumulate in memory

Full guide: [[pymupdf-industrial]]

---

## Workflow W5: Multi-Source Merge & Dedup

After running W1+W2+W3, merge results:

```python
# Dedup priority: DOI > title[:80] > title+year
all_papers = []
seen_keys = set()

for paper in all_sources:
    key = paper.get('doi') or paper['title'][:80].lower()
    if key not in seen_keys:
        seen_keys.add(key)
        all_papers.append(paper)

# Sort: GS cites > CNKI cites > OpenAlex cites
all_papers.sort(key=lambda p: p.get('cites', 0), reverse=True)
```

Full implementation: [[merge-dedup]]

---

## Traps Quick-Ref (Top 5 Most Fatal)

| # | Trap | Impact |
|---|------|--------|
| 1 | `print()` Chinese → crash | All Python workflows fail |
| 2 | PS 5.1 instead of 7+ | `[建议]` parsed as array operator |
| 3 | CDP `/navigate` for CNKI | URL params stripped, zero results |
| 4 | CNKI SSL → HTTPS direct | Chrome blocks with cert error |
| 5 | GS citation regex without full-width colon | Misses all Chinese-interface results |

Full catalog: [[traps-catalog]] (28 traps across 7 categories)

---

## Environment Requirements

| Item | Min Version | Notes |
|------|-----------|-------|
| Python | 3.10+ | Required for PyMuPDF + merge scripts |
| Node.js | 22+ | CDP proxy runtime |
| Chrome | Any recent | Remote debugging enabled |
| PowerShell | **7+ (NOT 5.1)** | PS 5.1 has UTF-8 bug |
| PyMuPDF | 1.24+ | `pip install PyMuPDF` |
| academic-search | latest | `npx skills install github:uranus421-glitch/academic-search` |

Run `bash scripts/check-env.sh` to verify all dependencies.

---

## Windows-Specific Notes

1. **Always use `pwsh` not `powershell`**: PS 5.1 UTF-8 bug
2. **`PYTHONIOENCODING=utf-8` in `~/.bashrc`**: Permanent fix
3. **Write to file, not console**: `open(path, 'w', encoding='utf-8')`
4. **Git Bash LANG**: `export LANG=en_US.UTF-8`

Full fix: [[windows-utf8-fix]]

---

## Reference Files

| File | Content |
|------|---------|
| [[traps-catalog]] | 28 known traps across 7 categories |
| [[cnki-kns8-selectors]] | CNKI KNS8 DOM selectors (2026-05) |
| [[scholar-chinese-citations]] | Google Scholar Chinese citation regex |
| [[windows-utf8-fix]] | Windows UTF-8 permanent fix |
| [[pymupdf-industrial]] | PyMuPDF annual report/patent extraction |
| [[merge-dedup]] | Multi-source dedup Python code |

---

*deep-lit v0.1.0 | Built on academic-search | Validated on Windows 11*
