# Traps Catalog — 已知陷阱完全目录

> 53 trapped & documented pitfalls from real-world chemical/materials industry research.
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

## CNKI 知网 (8 traps)

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

### CNKI-06: KNS8 pagination `.page-next` returns stale results
- **Symptom**: Clicking `.page-next` reloads page 1 results.
- **Root cause**: KNS8 SPA may not update the DOM after AJAX pagination; the selector re-queries the same loaded rows.
- **Fix**: Use `location.href` with `&page=N` parameter for each page, or manually scroll-trigger lazy load.

### CNKI-07: VPN triggers HTTP 418 anti-bot
- **Symptom**: `HTTP ERROR 418` on any CNKI request when VPN is active.
- **Root cause**: CNKI detects VPN/proxy IPs and returns teapot status.
- **Fix**: **Always use direct connection for CNKI** — no proxy, no VPN. This is the inverse of Google Scholar.

### CNKI-08: KNS8 homepage search box is custom component
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

## Sogou / Chinese Enterprise Search (3 traps)

### SOG-01: Bing Chinese routing bias
- **Symptom**: Bing search for Chinese company names returns Japanese travel or unrelated foreign-language results.
- **Root cause**: Bing tokenizes Chinese company names as city + other terms, and its international routing steers toward non-Chinese content.
- **Fix**: Always use Sogou for Chinese enterprise/industry search. Bing only as fallback for overseas sites.

### SOG-02: OpenAlex doesn't cover enterprise news
- **Symptom**: Search for company-university cooperation news returns 0 results on OpenAlex.
- **Root cause**: OpenAlex only indexes academic publications, not business news, company announcements, or industry-university cooperation reports.
- **Fix**: Corporate partnerships and enterprise news → W6 (Sogou). Academic literature → W1 (OpenAlex). These are different sources for different content types.

### SOG-03: Sogou snippets > JS-rendered source pages
- **Symptom**: `curl` cannot get full text from target website (JS-rendered SPA).
- **Root cause**: Many Chinese industry websites are SPAs / JS-rendered; curl only retrieves the HTML skeleton.
- **Fix**: The Sogou `cacheresult_summary` div usually contains the article's key information. Don't give up just because the source page is unreachable — the snippet is often sufficient.

---

## Industrial Clusters / Parks (2 traps)

### IPC-01: Park name confusion / 园区名称混淆
- **Symptom**: "某某高新区" and "某某经开区" are different entities with vastly different policies.
- **Root cause**: Chinese parks with similar names are governed by different ministries (科技部 for High-Tech Zones, 商务部 for Economic Development Zones, 工信部 for Chemical Parks), each with distinct tax/land policies.
- **Fix**: When searching, distinguish High-Tech Zone (科技部) / Economic Development Zone (商务部) / Chemical Park (工信部). Verify the park's administrative tier (national/provincial/municipal).

### IPC-02: Park reported figures vs actual operations
- **Symptom**: Official reports claim park output value of 50 billion but tenant company reported revenues total only 20 billion.
- **Root cause**: Park promotional data often includes "planned output value" or "target output value" that differs from company annual report figures.
- **Fix**: Cross-validate: park official site (claims) vs tenant company annual reports (actual capacity × unit price) vs government statistical bulletins.

---

## Patent Search (3 traps)

### PAT-01: Google Patents requires VPN from China
- **Symptom**: `patents.google.com` unreachable or times out.
- **Root cause**: Google services blocked in China without VPN.
- **Fix**: Use CDP browser with VPN enabled, same as Google Scholar (W2). Fallback: WIPO Patentscope for PCT applications (direct access).

### PAT-02: CNKI patent vs literature are different databases
- **Symptom**: CNKI literature search returns 0 patents, or patent search misses academic papers.
- **Root cause**: CNKI has separate databases — `dbcode=CJFD` for journals and `dbcode=SCDB` for patents. The search URL parameter differs.
- **Fix**: For patent search, use `dbcode=SCDB` in the KNS8 URL. For literature, use the default journal database. Do NOT mix search scopes.

### PAT-03: Patent family dedup — same invention in multiple jurisdictions
- **Symptom**: Same invention appears 5+ times (US, EP, CN, JP, WO) as separate results.
- **Root cause**: One invention filed in multiple patent offices creates a "patent family" with different publication numbers.
- **Fix**: Group by priority number (first filing). Google Patents shows family members; use the earliest priority date as the invention date. Dedup by INPADOC family ID when available.

---

## Regulatory Search (3 traps)

### REG-01: Chinese government sites are JS-rendered
- **Symptom**: `curl` or `WebFetch` returns empty body or spinner placeholder from `.gov.cn` sites.
- **Root cause**: Many Chinese government portals are SPAs built with React/Vue, requiring JS execution.
- **Fix**: Use `defuddle` for Chinese government sites (it handles JS rendering). For stubborn sites, fall back to Sogou search with `site:gov.cn` prefix for cached content.

### REG-02: Policy documents are PDFs — not HTML
- **Symptom**: Search results link to `.pdf` files that can't be parsed by text-based tools.
- **Root cause**: Official regulations, standards, and policy notices are published as PDF attachments, not web pages.
- **Fix**: Download the PDF, extract with W4 PyMuPDF pipeline. For Chinese PDFs, always write to UTF-8 file (PDF-01). Search PDF text for effective dates, scope, and numeric limits.

### REG-03: Standard numbering differs across jurisdictions
- **Symptom**: GB/T 12345 matches ISO 6789 in content but can't be found by cross-referencing the number.
- **Root cause**: Chinese GB standards may adopt ISO standards with modifications, but numbering systems are independent. GB/T ≠ ISO, GB ≠ EN, HJ ≠ EPA method.
- **Fix**: Search by subject matter + jurisdiction, not by standard number translation. Cross-reference using adoption statements (e.g., "GB/T XXXX 等同采用 ISO XXXX"). Use CNKI to find papers that compare standards across jurisdictions.

---

## Supply Chain Mapping (3 traps)

### SCM-01: Annual report supplier lists may be redacted
- **Symptom**: "Top 5 suppliers" section shows only percentages, no names, or names are redacted as "Supplier A/B/C".
- **Root cause**: Companies cite commercial confidentiality to avoid disclosing supplier identities; some regulators allow aggregated reporting.
- **Fix**: Cross-reference with industry association member lists, customs trade data (importer/exporter names), and credit rating reports which sometimes name key suppliers. Trade fair exhibitor lists are another source.

### SCM-02: HS codes ≠ company product categories
- **Symptom**: Searching UN Comtrade by HS code yields trade data that doesn't align with company-reported product segments.
- **Root cause**: HS (Harmonized System) codes are customs classification for tariff purposes. Company product categories are marketing/business segments. A single HS code may cover multiple product grades, and a single product may require multiple HS codes for its components.
- **Fix**: Map company products to HS codes using industry-specific concordance tables. For chemicals, CAS number → HS code lookups are more precise. Validate with industry association trade flow reports.

### SCM-03: News capacity figures ≠ annual report figures
- **Symptom**: News reports claim "Company X broke ground on 100kT/a plant" but annual report lists capacity as 30kT/a.
- **Root cause**: News reports often cite "planned/design capacity" or "total investment phase capacity" while annual reports disclose "operational/nameplate capacity" per accounting standards. Phased projects may be reported as full scale.
- **Fix**: Always cross-validate capacity claims: news (announcements) vs annual reports (audited operational figures) vs industry association statistics. Distinguish nameplate (design maximum), operational (current running rate), and planned (future phase) capacity.

---

## Investment Research (4 traps)

### INV-01: Chinese GAAP (CAS) vs IFRS vs US GAAP accounting differences
- **Symptom**: Revenue recognition, depreciation methods, and R&D capitalization rules differ across markets, making direct financial comparison misleading.
- **Root cause**: CAS (Chinese Accounting Standards) allows certain treatments (e.g., government subsidies recognized differently, related-party transaction rules) that IFRS and US GAAP handle differently. A-share financials are in CAS, HKEX may use IFRS or HKFRS, SEC requires US GAAP (or IFRS for foreign filers).
- **Fix**: When cross-comparing Chinese vs international companies, adjust for: (1) R&D capitalization — CAS allows more capitalization than IFRS; (2) government grants — CAS may classify as operating vs non-operating differently; (3) depreciation lives — CAS often uses shorter lives. Use `扣非归母净利润` (deducted non-recurring profit) for A-shares as closer to "core earnings."

### INV-02: Non-recurring items inflate reported profit
- **Symptom**: Company reports record net profit, but stripping out one-time asset sales reveals an operating loss.
- **Root cause**: Chinese annual reports prominently display `归母净利润` (net profit attributable to parent), but this includes non-recurring gains like asset disposals, government subsidies, and debt restructuring gains. For chemical companies, government relocation subsidies or carbon credit sales can materially distort earnings.
- **Fix**: Always use `扣非归母净利润` (deducted non-recurring net profit) as the primary earnings metric. Cross-check the "non-recurring gains/losses" section in the annual report notes. AKShare provides both fields: `归母净利润` and `扣非归母净利润`.

### INV-03: Capacity announcements ≠ audited revenue — utilization rate gap
- **Symptom**: News reports "Company X built 100kT/a plant" but annual report shows actual production of only 45kT and revenue consistent with ~50kT.
- **Root cause**: Nameplate capacity (design maximum), operational capacity (current running rate), and actual production are three different numbers. New plants may take 2-3 years to ramp up. Industry downturns reduce utilization. Annual reports disclose actual production volume and utilization rate; news reports cite design capacity.
- **Fix**: Extract `产能利用率` (capacity utilization rate) from annual reports via W4 PyMuPDF. Formula: actual production ÷ nameplate capacity. Use actual production volume × reported unit price to cross-validate revenue. Never use a single source for capacity claims.

### INV-04: Cross-market valuation comparison requires currency and accounting normalization
- **Symptom**: Comparing PE ratio of 万华化学 (A-share, CNY) to BASF (Xetra, EUR) without adjustments yields nonsense.
- **Root cause**: (1) Different accounting standards (CAS vs IFRS) affect earnings calculation; (2) Different fiscal year-ends (Dec 31 vs Mar 31); (3) Currency fluctuations; (4) Different capital structures (Chinese companies tend to have higher leverage); (5) Different tax rates and government subsidy levels.
- **Fix**: For cross-market comparison: (1) Use EV/EBITDA rather than P/E (capital-structure neutral); (2) Convert to common currency at period-end rate; (3) Normalize for non-recurring items; (4) Compare operating metrics (capacity, utilization, gross margin per ton) as a sanity check on financial multiples.

---

## Annual Report Scraping (3 traps)

### W5b-01: CNinfo API unstable — use Eastmoney fallback
- **Symptom**: AKShare `stock_zh_a_disclosure_report_cninfo()` returns KeyError or HTTP 500. CNinfo AJAX endpoint returns `{"error":"系统异常"}`.
- **Root cause**: CNinfo frequently changes internal API endpoints and adds anti-scraping measures. AKShare may lag behind CNinfo changes.
- **Fix**: Use Eastmoney API (`np-anotice-stock.eastmoney.com/api/security/ann`) as the primary listing source. For PDF download, use multi-path fallback: Sogou search `"{stock} {year}年报 filetype:pdf"` → Eastmoney annpdf API (may return empty) → CNinfo CDP browser → company IR website.

### W5b-02: HKEX披露易 is JS-rendered — CDP required
- **Symptom**: `curl` or `requests.get()` returns HTML skeleton with no report links. BeautifulSoup finds 0 PDF URLs.
- **Root cause**: HKEX披露易 is a React SPA. Report listing loaded via AJAX after page render. Direct HTTP only gets the empty template.
- **Fix**: Use CDP browser (same as W3 CNKI pipeline) to navigate and extract links. Alternative: AKShare `stock_financial_hk_report_em()` for structured financial data (no PDF but covers key metrics).

### W5b-03: secedgar API breaks between versions
- **Symptom**: `from secedgar import CIKLookup` works in v0.4 but fails in v0.6 with `ImportError`.
- **Root cause**: secedgar restructured between v0.4→v0.6. `CIKLookup` is now a class in `secedgar.cik_lookup`. `CompanyFilings` requires `cik_lookup` parameter.
- **Fix**: v0.6+: `from secedgar.cik_lookup import CIKLookup`; `CompanyFilings(cik=..., filing_type=..., cik_lookup=lookup_instance)`. Always check `secedgar.__version__` first.

---

*Catalog compiled: 2026-05-14 (updated 2026-05-15) | Source: 6-month real-world chemical/materials literature research*
