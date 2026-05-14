# CNKI KNS8 DOM Selectors Reference

> Validated against CNKI KNS8 platform as of 2026-05.
> If CNKI redesigns (KNS9, etc.), these selectors will break — update this doc.

## Search Results Page

### Result Count

| Element | CSS Selector | Example Output |
|---------|-------------|----------------|
| Total result count | `#countPageDiv .countText` | `"找到 531 条结果"` |

### Paper List Items

Each paper row is a `<tr>` inside `.result-table-list tbody`.

| Field | CSS Selector | Notes |
|-------|-------------|-------|
| Title | `td.name a` | Main link to paper detail |
| Authors | `td.author` | Semicolon-separated |
| Source (journal) | `td.source a` | Journal/conference name |
| Date | `td.date` | Format: `YYYY-MM-DD` |
| Citation count | `td.quote a` | May be empty for new papers |
| Database tag | `td.data a` | e.g. "学术期刊", "学位论文" |

### Extraction Example (CDP eval)

```javascript
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
```

## Pagination

| Action | Selector |
|--------|----------|
| Next page | `.page-next` |
| Previous page | `.page-prev` |
| Page N | `.page-num[data-page="N"]` |

### Pagination Example

```javascript
// Click next page
document.querySelector(".page-next")?.click()

// Wait 3-5 seconds between pages
```

## Search URL Structure

```
https://kns.cnki.net/kns8s/defaultresult/index?
  korder=SU           # Sort: SU=relevance, RT=time, CF=cited
  &kw=URL_ENCODED_KEYWORD
  &dbcode=CJFD        # CJFD=journals, CDMD=theses
  &page=1
```

| Parameter | Values | Notes |
|-----------|--------|-------|
| `korder` | `SU` (relevance), `RT` (time desc), `CF` (cited desc) | Default: SU |
| `kw` | URL-encoded UTF-8 | Must encode Chinese characters |
| `dbcode` | `CJFD` (journals), `CDMD` (theses/degree papers), empty (all) | |
| `page` | 1-based integer | Max ~10 before CAPTCHA |

## Known Breakage Points

1. **Search box on `www.cnki.net`**: Not a native `<input>`, cannot be targeted via DOM. Skip entirely, use direct KNS8 URL.
2. **Pagination**: After 10+ pages, CNKI injects CAPTCHA. Respect this limit.
3. **Result table**: `.result-table-list` may differ between KNS versions. Verify on first use each session.

---

*Last validated: 2026-05-14 | KNS8 platform*
