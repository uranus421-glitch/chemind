# Traps Catalog — 已知陷阱完全目录

> 28 trapped & documented pitfalls from real-world chemical/materials literature research.
> Each trap includes: platform, symptom, root cause, and fix.

---

## Google Scholar (4 traps)

### GS-01: Chinese citation format differs from English
- **Symptom**: `Cited by 133` regex works on English Scholar but misses Chinese results.
- **Root cause**: Chinese interface returns `被引用次数：133` (full-width colon).
- **Fix**: Use unified regex `被引用次数[：:]\s*(\d+) | Cited by (\d+)` in Python.

### GS-02: Citation count NOT in `.gs_fl` text
- **Symptom**: `el.querySelector(".gs_fl").textContent` doesn't contain citation count.
- **Root cause**: Citation count lives in a separate `<a>` tag, outside `.gs_fl`.
- **Fix**: Extract `allText: el.textContent.slice(0, 600)`, match citation count with regex.

### GS-03: JS filter fails in CDP eval context
- **Symptom**: `filter(t => t.includes("引用"))` returns 0 results in CDP eval.
- **Root cause**: CDP eval serialization may mangle Unicode in arrow functions.
- **Fix**: Do raw text extraction in CDP eval, then filter/match in Python on the host side.

### GS-04: VPN exit IP blocked by Google
- **Symptom**: HTTP 403 or CAPTCHA on `scholar.google.com` when using VPN.
- **Root cause**: Google blocks known VPN/proxy exit IPs.
- **Fix**: Fall back to user manually searching in browser → paste results → AI formats.

---

## CNKI 知网 (6 traps)

### CNKI-01: SSL certificate error
- **Symptom**: `NET::ERR_CERT_COMMON_NAME_INVALID` on `https://www.cnki.net`.
- **Root cause**: CNKI SSL certificate doesn't match the domain.
- **Fix**: Open via HTTP first (`http://www.cnki.net`), then jump to HTTPS KNS8 via `location.href`.

### CNKI-02: `/navigate` endpoint drops URL params
- **Symptom**: `/navigate?url=...` opens CNKI but search parameters are lost.
- **Root cause**: CNKI JavaScript SPA intercepts and rewrites URL on load.
- **Fix**: Use `location.href = "kns8 URL"` in CDP eval instead of the `/navigate` endpoint.

### CNKI-03: CAPTCHA requirement
- **Symptom**: Search results replaced by CAPTCHA challenge.
- **Root cause**: CNKI rate-limits automated access.
- **Fix**: User manually solves CAPTCHA in the Chrome window (shared cookie/session).

### CNKI-04: GBK encoding in curl params
- **Symptom**: Chinese keywords become garbled when passed via curl.
- **Root cause**: curl sends Latin-1 by default; CNKI expects UTF-8 URL encoding.
- **Fix**: Always URL-encode Chinese keywords: `%E5%B0%BC%E9%BE%991010` for 尼龙1010.

### CNKI-05: Pagination limits
- **Symptom**: After ~10 pages, results stop loading or CAPTCHA appears.
- **Root cause**: CNKI anti-scraping throttle.
- **Fix**: Limit to 10 pages per session, 3-5 second delay between pages.

### CNKI-06: KNS8 homepage search box is custom component
- **Symptom**: Can't `document.querySelector('input[type=text]')` and set value.
- **Root cause**: `www.cnki.net` uses a custom Web Component, not a native `<input>`.
- **Fix**: Skip the homepage entirely. Navigate directly to KNS8 result URL with `kw=` parameter.

---

## CDP / Proxy (3 traps)

### CDP-01: Chrome remote debugging resets on restart
- **Symptom**: CDP proxy returns `chrome not reachable` after Chrome restart.
- **Root cause**: `chrome://inspect/#remote-debugging` checkbox is per-session, not persisted.
- **Fix**: Always re-check the box after Chrome restart, then run `check-deps.sh`.

### CDP-02: CDP proxy needs restart after Chrome restart
- **Symptom**: Chrome is debug-ready but proxy says `connected: false`.
- **Root cause**: Proxy cache holds stale WebSocket connection to old Chrome process.
- **Fix**: Run `check-deps.sh` which auto-restarts proxy if Chrome PID changed.

### CDP-03: Tabs interfere with user's browsing
- **Symptom**: User's active tab gets replaced or polluted.
- **Root cause**: CDP `new?url=...` creates tab in foreground by default.
- **Fix**: Always close CDP-created tabs with `/close?target=$T` when done. Use background creation when possible.

---

## Windows / Encoding (5 traps)

### WIN-01: Python `print()` UnicodeEncodeError on Chinese
- **Symptom**: `UnicodeEncodeError: 'gbk' codec can't encode character '将'`.
- **Root cause**: Windows terminal default encoding is GBK (CP936).
- **Fix**: Set `PYTHONIOENCODING=utf-8` and `PYTHONUTF8=1` in `~/.bashrc`.

### WIN-02: PowerShell 5.1 misinterprets Chinese brackets
- **Symptom**: `[建议]` in a string is parsed as array operator `[建议]`.
- **Root cause**: PS 5.1 UTF-8 parsing bug with Chinese square brackets.
- **Fix**: **Always use PowerShell 7+ (`pwsh`)**, never PS 5.1 (`powershell`).

### WIN-03: Git Bash terminal garbled Chinese output
- **Symptom**: Chinese characters display as `????` or mojibake.
- **Root cause**: Git Bash LANG defaults to C or POSIX.
- **Fix**: `export LANG=en_US.UTF-8; export LC_ALL=en_US.UTF-8`.

### WIN-04: `chcp 65001` is temporary
- **Symptom**: UTF-8 codepage resets after terminal restart.
- **Root cause**: `chcp` only affects current session.
- **Fix**: Permanent registry key `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Nls\CodePage\OEMCP = 65001` or use the `~/.bashrc` method.

### WIN-05: Piping Python output to file loses encoding
- **Symptom**: `python3 script.py > output.txt` produces mojibake.
- **Root cause**: Shell pipe uses current codepage, not UTF-8.
- **Fix**: Always write to file from within Python with `open(path, 'w', encoding='utf-8')`. Never rely on shell redirection for Chinese.

---

## OpenAlex (3 traps)

### OA-01: Only covers academic journals
- **Symptom**: No results for industry reports, patents, or non-academic publications.
- **Root cause**: OpenAlex indexes journals, not grey literature.
- **Fix**: Use CNKI for Chinese industry papers, Google Patents for patent search.

### OA-02: Pre-2022 coverage is sparse
- **Symptom**: Few results for searches before 2022.
- **Root cause**: OpenAlex's primary coverage starts from 2022 for many fields.
- **Fix**: Use Google Scholar for pre-2022 high-citation classics.

### OA-03: Rate limit with aggressive polling
- **Symptom**: HTTP 429 after rapid-fire requests.
- **Root cause**: OpenAlex polite usage policy (10 req/s burst, 100k/day).
- **Fix**: Add 100ms delay between requests; use `select=` to minimize payload size.

---

## PyMuPDF / PDF Extraction (3 traps)

### PDF-01: `print()` causes GBK crash on Chinese PDF text
- **Symptom**: Same UnicodeEncodeError as WIN-01, but with PDF content.
- **Root cause**: PDF text is UTF-8; `print()` goes through GBK terminal.
- **Fix**: **Never `print()` Chinese PDF content.** Always write to a UTF-8 file, then read with `Read` tool.

### PDF-02: Annual reports lack TOC
- **Symptom**: `doc.get_toc()` returns empty list `[]`.
- **Root cause**: Industry annual reports don't embed PDF outline/TOC metadata.
- **Fix**: Extract all pages; use text pattern matching for section headers.

### PDF-03: Large PDF memory pressure
- **Symptom**: Python OOM on 500+ page PDFs.
- **Root cause**: `doc[i].get_text()` holds full page text in memory.
- **Fix**: Write page-by-page to file, don't accumulate in list. Use `with open(...)` context manager.

---

## Merge / Dedup (2 traps)

### MD-01: DOI missing for many Chinese papers
- **Symptom**: DOI-based dedup key is `None` for most CNKI results.
- **Root cause**: CNKI papers often lack DOIs.
- **Fix**: Fallback chain: DOI → title[:80].lower() → (title + year).

### MD-02: Citation count incomparable across sources
- **Symptom**: Google Scholar 200 citations vs CNKI 5 citations for same paper.
- **Root cause**: Different databases, different counting methods.
- **Fix**: Sort by source-priority: GS > CNKI > OpenAlex. Annotate source in merged output.

---

## Network / VPN (2 traps)

### NET-01: VPN must be on for Google Scholar from China
- **Symptom**: `scholar.google.com` unreachable.
- **Root cause**: Google services blocked in China without VPN.
- **Fix**: Prompt user to enable VPN first. Proxy: `socks5h://127.0.0.1:10808`.

### NET-02: `WebFetch` tool does NOT support proxy
- **Symptom**: `WebFetch` still fails even with VPN on.
- **Root cause**: `WebFetch` uses direct connection, ignores system proxy.
- **Fix**: Use `curl --proxy socks5h://127.0.0.1:10808` for VPN-required URLs instead of `WebFetch`.

---

## General Workflow (2 traps)

### WF-01: Chrome session shared between user and CDP
- **Symptom**: CDP CAPTCHA solve affects user's Chrome session.
- **Root cause**: CDP attaches to the same Chrome instance the user browses with.
- **Fix**: Use a dedicated Chrome profile for CDP if frequent CAPTCHAs are expected.

### WF-02: Multi-source search without dedup creates duplicate notes
- **Symptom**: Same paper appears 3 times in final vault note.
- **Root cause**: Each source (OpenAlex, GS, CNKI) returns overlapping results.
- **Fix**: Always run `merge-dedup` step after multi-source search. See [[merge-dedup]].

---

*Catalog compiled: 2026-05-14 | Source: 6-month real-world chemical/materials literature research*
