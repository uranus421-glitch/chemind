---
name: synthon
description: |
  Chemical / Bio-Based Materials / Polymer / Life Sciences Industry Multi-Dimensional Deep Research.
  Covering academic literature, patents, market data, production capacity, supply chains,
  standards/regulations, AI-driven materials discovery, investment analysis,
  industrial clusters/parks, AI+ all industries, specialty chemicals, agrochemicals,
  energy materials, food tech, cosmetics ingredients. Now with biopharma/CGT dimension.
  Built on academic-search for CDP infrastructure.

  化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究 Claude Code Skill。
  覆盖学术文献、专利、市场数据、产能产量、产业链、标准法规、AI 驱动材料发现、
  投资分析、产业聚集区/产业园、AI+全行业、精细化工、农用化学品、能源材料、食品科技、化妆品原料。
  新增生命科学/生物制药/细胞基因治疗维度。Built on academic-search for CDP infrastructure.

  Mehrdimensionale Tiefenforschung für Chemie- / Biobasierte Materialien / Polymer- / Biowissenschaften.
  Deckt Literatur, Patente, Marktdaten, Produktionskapazitäten, Lieferketten, Normen,
  KI-gestützte Materialentdeckung, Investmentanalyse, Industriecluster/Parks, KI+ alle Branchen,
  Feinchemikalien, Agrochemikalien, Energiematerialien, Lebensmitteltechnologie, Kosmetik-Rohstoffe ab.
  Jetzt mit Biopharma/CGT-Dimension.

  Triggers / 触发词 / Auslöser:
  Chemical industry research, bio-based materials, polymer market, production capacity,
  supply chain analysis, materials patents, AI materials design, technology landscape,
  competitive analysis, annual reports, biopharma, biosimilars, mAb, ADC, CGT, CHO, CDMO,
  IPO, M&A, due diligence, competitor benchmarking, regulatory pathway, supply chain mapping,
  industrial park, chemical park, high-tech zone, 产业园, 化工区, 高新区,
  AI+制药, AI+化工, AI+能源, AI+材料, 精细化工, 农用化学品, 能源材料, 食品科技, 化妆品原料
metadata:
  version: "0.3.0"
  depends-on: ["academic-search"]
---

# synthon

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
├─ "latest papers" / "最新论文" → W1: OpenAlex
├─ "high-citation reviews" / "高引综述" → W2: GS CDP (VPN required / 需VPN)
├─ "CNKI" / "知网" / "学位论文" → W3: CNKI CDP (NO VPN! / 禁止VPN!)
├─ "annual report" / "年报" / "招股书" → W4: PyMuPDF + W5b: Batch Scraping
├─ "market" / "市场" / "产能" → W6: Sogou Enterprise Search + W1 OpenAlex
├─ "company news" / "企业新闻" / "合作" → W6: Sogou Enterprise Search
├─ "patents" / "专利" → W7: Patent Search
├─ "AI+materials" / "AI+材料" / "AI+医药" / "AI+化工" → W8: AI + All Industries
├─ "investment" / "IPO" / "M&A" / "投资" → W9: Investment Research
├─ "regulations" / "法规" / "政策" → W10: Regulatory Search
├─ "supply chain" / "产业链" → W11: Supply Chain Mapping
├─ "industrial park" / "产业园" / "化工区" / "高新区" / "产业聚集" → W12: Industrial Clusters & Parks
│
├─ 🏭 化工/材料 → W1→W2→W3 merge | W6 Sogou | W7 专利 | W12 化工园区
│   示例: BASF, Dow, DuPont, Evonik, Covestro, 万华化学, 恒力石化
├─ 🧬 生物制药+生物技术 → Upstream/Downstream/Analytics/CGT/Industrial biotech/CDMO
│   示例: Roche, Novartis, Pfizer, Genomatica, Ginkgo Bioworks, 恒瑞医药, 百济神州, 药明生物
├─ 💰 投资分析 → W4 招股书 + W6 新闻 + W9 财务提取 + W9d 竞对标
│   示例: 宁德时代(CATL), 比亚迪, 小米集团
├─ 🧪 精细化工 → W6 供应链 + W7 专利 + W11 产业链
│   示例: DSM, Symrise, Givaudan, IFF, Lonza, 新和成
├─ 🌾 农用化学品 → W1 文献 + W6 登记动态 + W10 各国法规
│   示例: Syngenta, Bayer CropScience, Corteva, UPL, 扬农化工
├─ 🔋 能源材料 → W1 文献 + W6 产能新闻 + W7 专利 + W12 产业集群
│   示例: 宁德时代, 比亚迪, LG Energy Solution, 天赐材料, 恩捷股份
├─ 🍽️ 食品科技 → W1 文献 + W9 投融资 + W7 专利
│   示例: Cargill, ADM, Nestlé, Impossible Foods, 伊利
├─ 💄 化妆品原料 → W1 文献 + W6 市场 + W7 专利 + W10 法规
│   示例: L'Oréal, Estée Lauder, 华熙生物, 珀莱雅
├─ 🏗️ 产业聚集区 → W12 集群分布 + W10 差异化政策 + W6 园区新闻
│   示例: 上海化工区, 南京江北新材料科技园, 泰州医药城, 张江药谷, BASF Ludwigshafen, Singapore Jurong Island, Houston Ship Channel, Frankfurt Höchst
├─ 🤖 AI+产业 → W8 技术文献 + W6 应用新闻 + W9 投融资 + 跨行业交叉
└─ "industry panorama" / "产业全景" → ALL → merge
```

---

## Workflow W1: OpenAlex API Search

No CDP required. No API key. No rate limit.
无 CDP / 无 API Key / 无速率限制。
Kein CDP erforderlich. Kein API-Schlüssel. Keine Ratenbegrenzung.

```bash
curl -s "https://api.openalex.org/works?filter=title_and_abstract.search:KEYWORD,publication_year:2023-2026&sort=cited_by_count:desc&per_page=20&select=id,doi,title,publication_date,cited_by_count,authorships,open_access" \
  -H "User-Agent: synthon/0.3.0 (mailto:your@email.com)" \
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

Batch download & analysis of annual reports from A-share (Eastmoney/CNinfo), HKEX, and SEC EDGAR.
A股(东方财富/巨潮) / 港股(披露易) / 美股(SEC EDGAR) 年报批量下载与分析。

**Tool Selection / 工具选型:**

| Market / 市场 | Tool / 工具 | Method / 方法 | Notes / 说明 |
|------|------|------|------|
| A-share / A股 | Eastmoney API (list) → Sogou/CDP (download) | `requests` + 4-path fallback | 东方财富API稳定列公告，PDF下载需降级链路 |
| HKEX / 港股 | HKEX披露易 + Selenium | CDP browser | JS渲染SPA，需CDP |
| US / ADR / 美股 | secedgar v0.6+ | `CompanyFilings` + `CIKLookup` | 10-K / 20-F / S-1 |

---

### 🇨🇳 A-Share: Eastmoney API Listing + Multi-Path PDF Download

**Step 1: List annual reports via Eastmoney API / 东方财富API列年报**:

```python
import requests

def list_annual_reports(stock_code, max_pages=3):
    """List annual reports for A-share stock via Eastmoney API.
    
    Args:
        stock_code: e.g. '600309' (万华化学), '300750' (宁德时代)
        max_pages: max pages to fetch (10 reports/page)
    
    Returns:
        List of {title, date, art_code, pdf_url}
    """
    reports = []
    for page in range(1, max_pages + 1):
        params = {
            'page_size': 30,
            'page_index': page,
            'ann_type': 'A',
            'client_source': 'web',
            'stock_list': stock_code,
            'f_node': '1',  # 1=财务报告 category
            's_node': '0',
        }
        headers = {
            'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36',
            'Referer': 'https://data.eastmoney.com/',
        }
        r = requests.get(
            'https://np-anotice-stock.eastmoney.com/api/security/ann',
            params=params, headers=headers, timeout=15
        )
        data = r.json()
        items = data.get('data', {}).get('list', [])
        if not items:
            break
        for item in items:
            title = item.get('title', '')
            if '年报' in title and '摘要' not in title:
                art_code = item.get('art_code', '')
                date = item.get('notice_date', '')[:10]
                # CNinfo PDF URL pattern
                # Eastmoney direct PDF API (no CNinfo redirect needed)
                pdf_url = f'https://np-anotice-stock.eastmoney.com/api/security/annpdf?art_code={art_code}&client_source=web'
                reports.append({
                    'title': title,
                    'date': date,
                    'art_code': art_code,
                    'pdf_url': pdf_url,
                })
    return reports

# Example / 示例
reports = list_annual_reports('600309')
for r in reports[:3]:
    print(f'[{r[\"date\"]}] {r[\"title\"][:70]}')
    print(f'  → {r[\"pdf_url\"]}')
```

**Step 2: PDF Download — Multi-Path Fallback / PDF下载多路径降级**:

> ⚠️ Eastmoney PDF API (`/api/security/annpdf`) returns empty response (anti-scraping). CNinfo direct API unstable. Use the following layered fallback strategy.

```
Path 1: Sogou Search ({优先})     → "{股票简称} {年份}年报 filetype:pdf"
         ↓ (if no direct PDF link)
Path 2: Eastmoney PDF API (备选)   → /api/security/annpdf?art_code={code} (may work intermittently)
         ↓ (if empty/403)
Path 3: CNinfo CDP Browser (兜底)  → CDP navigate to static.cninfo.com.cn finalpage PDF
         ↓ (if VPN/proxy blocked)
Path 4: Company IR Website (最后)  → 公司官网"投资者关系"页面手动定位
```

**Path 1: Sogou mirror search / 搜狗镜像搜索** (preferred first attempt):

```bash
# Search for annual report PDF mirrors on Chinese web
STOCK="万华化学"
YEAR="2025"
QUERY=$(python3 -c "import urllib.parse; print(urllib.parse.quote('${STOCK} ${YEAR}年报 filetype:pdf'))")
curl -s "https://www.sogou.com/web?query=$QUERY" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  -L -o /tmp/sogou_pdf.html

# Extract PDF URLs from results
grep -oP 'href="[^"]*\.pdf[^"]*"' /tmp/sogou_pdf.html | head -5
# wget each result to check size > 500KB (filter out summary pages)
```

**Path 2: Direct download attempt / 直连尝试** (simple fallback):

```python
import requests

def try_download(report, out_dir='/tmp/annual_reports'):
    """Attempt PDF download via Eastmoney API. May return empty."""
    os.makedirs(out_dir, exist_ok=True)
    url = f"https://np-anotice-stock.eastmoney.com/api/security/annpdf?art_code={report['art_code']}&client_source=web"
    headers = {'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36'}
    r = requests.get(url, headers=headers, timeout=30)
    if r.status_code == 200 and len(r.content) > 50000:  # >50KB = real PDF
        fpath = os.path.join(out_dir, f"{report['date']}_{report['art_code']}.pdf")
        with open(fpath, 'wb') as f:
            f.write(r.content)
        return fpath
    return None  # Fall through to Path 3/4
```

**Path 3: CNinfo CDP browser / CNinfo CDP浏览器** (requires CDP + VPN OFF):

```bash
PROXY="http://127.0.0.1:3456"
CNINFO_PDF="https://static.cninfo.com.cn/finalpage/{date}/{art_code}.PDF"
# Navigate via CDP, wait for load, save PDF via chrome.downloads
```

**Path 4: Company IR website / 公司官网投资者关系** (manual):
- A-share: Search `{公司名} 投资者关系` → IR page → 定期报告
- HKEX: Use HKEX披露易 CDP (reliable, see HKEX section below)
- SEC: Use secedgar (reliable, see SEC section below)

---

### 🇭🇰 HKEX: 披露易 CDP / Selenium Approach

HKEX披露易是 JS 渲染 SPA，curl/requests 不可用。使用 CDP browser 获取。

```python
# Approach: HKEX披露易 search → CDP browser → extract PDF links
# 1. Navigate to HKEX披露易 search page
# 2. Search by stock code (e.g., 00700=Tencent)
# 3. Filter: 年报/Annual Reports, Headline Category: Annual Reports
# 4. Extract PDF download links

# Alternative: AKShare HK financial data (no PDF, structured data)
import akshare as ak
df = ak.stock_financial_hk_report_em(symbol='00700', indicator='利润表')
```

**HKEX CDP 模板**:

```bash
PROXY="http://127.0.0.1:3456"
HKEX_SEARCH="https://www.hkexnews.hk/search/titlesearch.xhtml?stockId=CODE&t1code=2"

T=$(curl -s "$PROXY/new?url=$HKEX_SEARCH" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 5

# Extract report links / 提取报告链接
curl -s -X POST "$PROXY/eval?target=$T" -d '
JSON.stringify(Array.from(document.querySelectorAll("a[href*=\".pdf\"]")).map(a => ({
  title: a.textContent.slice(0, 100),
  href: a.href
})))' -o /tmp/hkex_reports.json

curl -s "$PROXY/close?target=$T"
```

---

### 🇺🇸 SEC EDGAR: secedgar v0.6+ 10-K Download

secedgar v0.6.0 API:

```python
from secedgar import CompanyFilings, FilingType
from secedgar.cik_lookup import CIKLookup

# Step 1: Get CIK / 获取公司CIK编号
cik_lookup = CIKLookup('Apple Inc')
apple_cik = cik_lookup.cik  # Returns '0000320193'

# Step 2: Download 10-K filings / 下载10-K年报
filings = CompanyFilings(
    cik=apple_cik,
    filing_type=FilingType.FILING_10K,
    count=3,  # Last 3 years
    cik_lookup=cik_lookup,
)
filings.save('/tmp/sec_filings')

# Step 3: Each filing folder contains .txt (HTML) + extracted tables
# Feed to W4 PyMuPDF pipeline for financial table extraction

# For non-US companies (ADR): use FilingType.FILING_20F instead
# 中概股/ADR: 用 FILING_20F (foreign annual report)
```

**Common CIKs / 常用CIK**:

| Company / 公司 | CIK | Filing Type / 文件类型 |
|------|------|------|
| Apple | 0000320193 | 10-K |
| NVIDIA | 0001045810 | 10-K |
| Alibaba / 阿里巴巴 | 0001577552 | 20-F |
| JD.com / 京东 | 0001549802 | 20-F |
| BASF (ADR) | 0000896214 | 20-F |

---

### Pipeline: Download → Extract → Structure / 下载→提取→结构化

```
1. List reports (Eastmoney / HKEX CDP / secedgar)
   ↓
2. Download PDF (requests / Selenium / secedgar)
   ↓
3. W4 PyMuPDF → full-text extraction (UTF-8 file)
   ↓
4. W9 Investment Research → key financial metrics extraction
   ↓
5. Write to vault note with frontmatter + wiki-links
```

**Traps**: W5b-01 (CNinfo API unstable — use Eastmoney fallback), W5b-02 (HKEX JS-rendered — must use CDP/Selenium), W5b-03 (secedgar API breaks between versions — check version first)

---

## Workflow W6: Sogou Enterprise News & Industry Search / 搜狗企业新闻与行业搜索 / Sogou Unternehmens- und Branchensuche

Chinese enterprise news, industry-university cooperation, industry dynamics, policy announcements, company announcements.
中文企业新闻、产学研合作、行业动态、政策公告、公司公告。
Chinesische Unternehmensnachrichten, Industrie-Hochschul-Kooperation, Branchendynamik, politische Ankündigungen.

**Key advantage / 核心优势 / Hauptvorteil**: curl direct connection (no CDP/VPN needed). Sogou snippets often contain key information even when the target site is JS-rendered.
curl 直连 (无需 CDP/VPN)。搜狗摘要常包含关键信息，即使目标网站是 JS 渲染。
curl-Direktverbindung (kein CDP/VPN nötig). Sogou-Snippets enthalten oft Schlüsselinformationen, selbst wenn die Zielseite JS-gerendert ist.

**Search strategy / 搜索策略 / Suchstrategie**: broad terms → progressively narrow.
宽泛词 → 逐步收窄。
Breite Begriffe → schrittweise eingrenzen.

```bash
# STEP 1: Search / 搜索 / Suche
curl -s "https://www.sogou.com/web?query=URL_ENCODED_QUERY" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  -L -o /tmp/sogou_result.html

# STEP 2: Extract title + snippet / 提取标题+摘要 / Titel+Snippet extrahieren
grep -oP '<div class="fz-mid space-txt[^"]*"[^>]*>.*?</div>' /tmp/sogou_result.html \
  | python3 -c "
import sys, re
for line in sys.stdin:
    text = re.sub(r'<[^>]+>', '', line)
    text = re.sub(r'&nbsp;', ' ', text)
    text = re.sub(r'&quot;', chr(34), text)
    text = re.sub(r'\s+', ' ', text).strip()
    if len(text) > 20:
        print(text[:600])
        print()
"

# STEP 3 (optional): Full result container with URL & date / 完整结果容器含URL和日期
grep -oP '<div class="vrwrap".*?</div>\s*</div>\s*<!--STATUS' /tmp/sogou_result.html \
  | python3 -c "
import sys, re
for i, line in enumerate(sys.stdin):
    text = re.sub(r'<[^>]+>', '', line)
    text = re.sub(r'\s+', ' ', text).strip()
    if len(text) > 30:
        print(f'=== Result {i} ===')
        print(text[:800])
        print()
"
```

**Tips / 技巧 / Tipps**:
- Read snippets first → decide if original page is worth visiting / 先读摘要 → 再决定是否访问原文
- Quote full names with `"` for better precision / 全名带引号搜索命中更多
- `cacheresult_summary` div often has core facts even for JS-rendered sites / 搜狗摘要常包含关键信息

**Traps**: SOG-01 (Bing Chinese routing bias), SOG-02 (OpenAlex ≠ enterprise news), SOG-03 (Sogou snippets > JS source pages)

---

## Workflow W7: Patent Search / 专利搜索 / Patentsuche

Global patent search across multiple jurisdictions. Covers Google Patents, CNKI patent DB, and patent family mapping.
全球多法域专利检索。覆盖 Google Patents、CNKI 专利库与专利家族映射。
Globale Patentrecherche über mehrere Rechtsordnungen. Deckt Google Patents, CNKI-Patentdatenbank und Patentfamilien-Mapping ab.

**Source selection / 源选择 / Quellenauswahl**:

| Source / 源 | Access / 访问 | VPN | Best for / 最适合 |
|------|------|:---:|------|
| Google Patents | CDP browser | 🚧 必须 | Global patents, family mapping, prior art |
| CNKI Patent DB | CDP browser | 🛑 禁止 | Chinese patents, utility models |
| WIPO Patentscope | Direct / WebFetch | 无所谓 | PCT applications, international search |

**Google Patents via CDP / Google Patents CDP 检索**:

```bash
PROXY="http://127.0.0.1:3456"
QUERY="URL_ENCODED_KEYWORD"  # e.g. polyamide%20bio-based

# Open search results / 打开搜索结果
T=$(curl -s "$PROXY/new?url=https://patents.google.com/?q=$QUERY&before=priority:20230101&language=EN" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 4

# Extract patent list / 提取专利列表
curl -s -X POST "$PROXY/eval?target=$T" -d '
JSON.stringify(Array.from(document.querySelectorAll("search-result-item")).slice(0,20).map(el => ({
  title: el.querySelector(".result-title")?.textContent?.trim(),
  assignee: el.querySelector(".assignee")?.textContent?.trim(),
  snippet: el.querySelector(".snippet, .abstract")?.textContent?.trim()?.slice(0,500),
  status: el.querySelector(".status")?.textContent?.trim(),
  priorityDate: el.querySelector(".priority-date")?.textContent?.trim()
})))' -o /tmp/patents_google.json

curl -s "$PROXY/close?target=$T"
```

**CNKI Patent Search via CDP / CNKI 专利 CDP 检索**:

```bash
PROXY="http://127.0.0.1:3456"

# 1. HTTP homepage (NO VPN) / HTTP 主页 (禁止 VPN)
CNKI=$(curl -s "$PROXY/new?url=http://www.cnki.net" \
  | node -p "JSON.parse(require('fs').readFileSync(0,'utf8')).targetId")
sleep 5

# 2. Jump to KNS8 patent search / 跳转 KNS8 专利检索
curl -s -X POST "$PROXY/eval?target=$CNKI" -d \
  'location.href = "https://kns.cnki.net/kns8s/defaultresult/index?korder=SU&dbcode=SCDB&kw=URL_ENCODED_KEYWORD"' > /dev/null
sleep 8

# 3. Extract / 提取
curl -s -X POST "$PROXY/eval?target=$CNKI" -d '
JSON.stringify({
  totalCount: document.querySelector("#countPageDiv .countText")?.textContent?.trim(),
  patents: Array.from(document.querySelectorAll(".result-table-list tbody tr")).slice(0,20).map(tr => ({
    title:   tr.querySelector("td.name a")?.textContent?.trim(),
    applicant: tr.querySelector("td.author")?.textContent?.trim(),
    date:    tr.querySelector("td.date")?.textContent?.trim(),
    status:  tr.querySelector("td.source")?.textContent?.trim()
  }))
})' -o /tmp/patents_cnki.json

curl -s "$PROXY/close?target=$CNKI"
```

**Search strategy / 检索策略 / Suchstrategie**:
- IPC codes for technical scope: `C08G69/` (polyamides), `C12P7/` (fermentation)
- Assignee search: `assignee:"BASF"` or `"万华化学"` as applicant
- Cross-reference patent families to avoid double-counting
- Priority date > publication date for novelty analysis

**Traps**: PAT-01 (Google Patents needs VPN), PAT-02 (CNKI patent vs literature different DB), PAT-03 (patent family dedup)

---

## Workflow W8: AI + Industry / AI + 产业 / KI + Industrie

Covers AI applications across ALL industries — not just materials.
覆盖 AI 在所有行业的应用——不仅限于材料。
Deckt KI-Anwendungen in ALLEN Branchen ab — nicht nur Materialien.

```
AI + Industry / AI + 产业 / KI + Industrie
├─ 🤖 AI+材料 / KI+Materialien: ML inverse design, polymer informatics, high-throughput screening
├─ 🧬 AI+制药 / KI+Pharma: AlphaFold, molecular docking, drug repurposing, clinical trial optimization
├─ 🏭 AI+化工 / KI+Chemie: process optimization, PINN hybrid modeling, predictive maintenance
├─ 🔋 AI+能源 / KI+Energie: battery materials discovery, grid optimization, catalyst design
├─ 🌾 AI+农业 / KI+Landwirtschaft: precision agriculture, crop protection AI, biostimulant formulation
├─ 💄 AI+化妆品 / KI+Kosmetik: skin microbiome AI, formulation optimization, in silico safety
└─ 💰 AI+投资 / KI+Investment: quantitative analysis, alternative data, NLP on filings
```

**Search methods / 搜索方法 / Suchmethoden**:
- OpenAlex: `"artificial intelligence" + [domain keyword]` → academic papers
- W6 Sogou: `[公司名] + AI + [应用场景]` → enterprise AI deployment news
- W9 Investment Research → AI startup funding rounds

**Traps**: OA-01 (OpenAlex academic only), SOG-02 (enterprise news not in OpenAlex)

---

## Workflow W9: Investment Research / 投资分析 / Investmentanalyse

IPO, M&A, financial data extraction, valuation, and competitor benchmarking across A-share, HKEX, and SEC EDGAR markets.
IPO/并购/财务数据提取/估值/竞品对标，覆盖A股、港股、美股三大市场。
IPO, M&A, Finanzdatenextraktion, Bewertung und Wettbewerbsbenchmarking über A-Share-, HKEX- und SEC-EDGAR-Märkte.

**Data sources by market / 各市场数据源 / Datenquellen nach Markt**:

| Market / 市场 | Source / 源 | Method / 方法 | Coverage / 覆盖 |
|------|------|------|------|
| 🇨🇳 A-share / A股 | AKShare Python API | `ak.stock_financial_abstract_ths()` | 5,000+ listed companies |
| 🇨🇳 A-share / A股 | CNinfo / 巨潮资讯 | Annual report PDF download (W5b) | All A-share filings |
| 🇭🇰 HKEX / 港股 | HKEX披露易 | Selenium + PyMuPDF | 2,500+ listed companies |
| 🇺🇸 US / ADR / 美股 | SEC EDGAR | `secedgar` Python library | 10-K, 20-F, 8-K, S-1 |
| 🌍 Cross-market / 跨市场 | Annual reports (W4) | PyMuPDF → structured financials | All PDF reports |

**Key financial metrics / 核心财务指标 / Finanzkennzahlen**:

| Metric / 指标 | A-share / A股 | HKEX / 港股 | US SEC / 美股 |
|------|------|------|------|
| Revenue / 营收 | 营业收入 | Revenue / 收益 | Total Revenue |
| Gross margin / 毛利率 | 毛利率 = (营收-营业成本)/营收 | Gross Profit Margin | Gross Margin |
| R&D ratio / 研发率 | 研发费用/营收 | R&D Expense/Revenue | R&D to Revenue |
| Net profit / 净利润 | 归母净利润 | Profit attributable to owners | Net Income |
| Capacity / 产能 | 年报"产能/产量" | Annual report capacity | Capacity/Production |
| Top 5 customers / 前五大客户 | 前五名客户占比 | Top 5 Customers % | Customer Concentration |
| Capex / 资本开支 | 购建固定资产支出 | Capital Expenditure | CapEx |

**AKShare A-Share Financial Extraction / A股财务数据提取**:

```python
import akshare as ak

# Company financial abstract / 公司财务摘要
# Symbol examples / 代码示例: 300750=宁德时代, 002594=比亚迪, 600309=万华化学
df = ak.stock_financial_abstract_ths(symbol="300750", indicator="按报告期")

# Key fields / 关键字段:
# - 营业总收入, 营业总成本, 研发费用
# - 归母净利润, 扣非归母净利润 (excl. non-recurring)
# - 基本每股收益, 加权平均净资产收益率

# For competitor comparison / 竞品对比:
symbols = ["300750", "002594", "300014"]  # CATL, BYD, EVE Energy
for sym in symbols:
    df = ak.stock_financial_abstract_ths(symbol=sym, indicator="按报告期")
    print(f"\n=== {sym} ===")
    print(df[["报告期", "营业总收入", "归母净利润", "研发费用"]].head(5))
```

**SEC EDGAR US Filing Extraction / 美股 SEC 文件提取**:

```bash
pip install secedgar
```

```python
from secedgar import FilingType, CIKLookup
import datetime

# Download 10-K filings / 下载 10-K 年报
# CIK examples: 0000320193=Apple, 0001045810=NVIDIA
# Use CIKLookup for company name → CIK conversion

# Full workflow / 完整流程:
# 1. Download 10-K → 2. Extract HTML/PDF → 3. W4 PyMuPDF for table extraction
# See [[annual-report-scraping]] for detailed pipeline
```

**Annual Report Key Section Extraction / 年报关键词定位**:

```python
# From W4 PyMuPDF output, extract financial narrative sections
import re

with open('/tmp/pdf_output.txt', 'r', encoding='utf-8') as f:
    text = f.read()

sections = {
    'revenue_breakdown': r'(营业收入.*?分析|主营业务.*?分产品).*?((?:[一-鿿]+,?\s*){2,20})',
    'capacity_utilization': r'(产能利用率|开工率).*?(\d+\.?\d*%)',
    'rd_projects': r'(研发项目|在研项目).*?((?:[一-鿿]+[,，、]){3,15})',
    'risk_factors': r'(风险因素|风险提示).*?((?:[一-鿿]+[,，、]){3,20})',
    'customer_concentration': r'前五名客户.*?合计.*?(\d+\.?\d*%)',
    'subsidies': r'(政府补助|补贴).*?(\d+\.?\d*\s*万元)',
}

for key, pattern in sections.items():
    matches = re.findall(pattern, text, re.DOTALL)
    if matches:
        print(f'\n=== {key} ===')
        for m in matches[:3]:
            print(f'  {str(m)[:300]}')
```

**Competitor Benchmarking (W9d) / 竞品对标**:

```
Benchmark Template / 对标模板:
├─ Company A / 公司A vs Company B / 公司B
│   ├─ Revenue / 营收: ¥___B vs ¥___B (YoY: ___% vs ___%)
│   ├─ Gross Margin / 毛利率: ___% vs ___%
│   ├─ R&D % / 研发率: ___% vs ___%
│   ├─ ROE / 净资产收益率: ___% vs ___%
│   ├─ Capacity / 产能: ___ t/a vs ___ t/a
│   ├─ Top 5 Customer % / 客户集中度: ___% vs ___%
│   └─ Employee count / 员工数: ___,___ vs ___,___
└─ Source / 数据源: FY2025 annual report / 2025年报
```

**Traps**: INV-01 (GAAP/IFRS/CAS accounting differences), INV-02 (non-recurring items inflate profit), INV-03 (capacity ≠ audited revenue — utilization varies), INV-04 (cross-market comparison needs currency/accounting normalization)

---

## Workflow W10: Regulatory Search / 法规政策搜索 / Regulierungssuche

Multi-jurisdiction regulatory and policy document search. Covers chemical regulations, pharmaceutical approvals, environmental standards, and trade policies.
多法域法规政策文件检索。覆盖化学品法规、药品审批、环保标准与贸易政策。
Multi-Jurisdiktion-Recherche zu Vorschriften und politischen Dokumenten. Deckt Chemikalienvorschriften, Arzneimittelzulassungen, Umweltnormen und Handelspolitik ab.

**Key regulators by jurisdiction / 各法域主要监管机构**:

| Jurisdiction / 法域 | Regulator / 监管机构 | Domain / 域名 | Access / 访问 |
|------|------|------|:---:|
| 🇨🇳 China | 生态环境部 MEE | `mee.gov.cn` | Defuddle / Sogou |
| 🇨🇳 China | 国家药监局 NMPA | `nmpa.gov.cn` | Defuddle |
| 🇨🇳 China | 应急管理部 MEM | `mem.gov.cn` | Defuddle |
| 🇨🇳 China | 工信部 MIIT | `miit.gov.cn` | Defuddle |
| 🇨🇳 China | 国家发改委 NDRC | `ndrc.gov.cn` | Defuddle |
| 🇺🇸 US | EPA | `epa.gov` | WebFetch / VPN |
| 🇺🇸 US | FDA | `fda.gov` | WebFetch / VPN |
| 🇪🇺 EU | ECHA | `echa.europa.eu` | WebFetch / VPN |
| 🇪🇺 EU | EMA | `ema.europa.eu` | WebFetch / VPN |
| 🌍 Global | WHO | `who.int` | WebFetch / VPN |

**Regulation types by domain / 按领域的法规类型 / Verordnungstypen nach Bereich**:

| Domain / 领域 | 🇨🇳 China | 🇺🇸 US | 🇪🇺 EU |
|------|------|------|------|
| Chemicals / 化学品 | 危险化学品目录 + 新化学物质登记 | TSCA | REACH + CLP |
| Pharmaceuticals / 药品 | NMPA 注册 + 医保目录 | FDA NDA/BLA | EMA MA + centralized procedure |
| Food Contact / 食品接触 | GB 9685 正面清单 | FDA FCN | EU 10/2011 |
| Cosmetics / 化妆品 | NMPA 备案 + 已使用原料目录 | FDA MoCRA | EU 1223/2009 |
| Environment / 环保 | 排污许可 + 环境税 | Clean Air/Water Act | Industrial Emissions Directive |
| Trade / 贸易 | 出口管制 + 两用物项 | EAR + ITAR | Dual-Use Regulation |

**Search methods / 搜索方法 / Suchmethoden**:

```bash
# 🇨🇳 China: defuddle for .gov.cn sites / 中国 gov.cn 站点用 defuddle
defuddle parse "https://www.mee.gov.cn/search?q=KEYWORD" --md

# Fallback: Sogou site-specific search / 兜底: 搜狗站内搜索
curl -s "https://www.sogou.com/web?query=site:mee.gov.cn+KEYWORD" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  -L -o /tmp/reg_sogou.html

# 🇺🇸/🇪🇺: WebFetch or curl via VPN
curl --proxy socks5h://127.0.0.1:10808 \
  "https://www.epa.gov/search?query=KEYWORD" -L -o /tmp/reg_epa.html

# 🇪🇺 ECHA: substance search / 物质搜索
curl --proxy socks5h://127.0.0.1:10808 \
  "https://echa.europa.eu/search?query=SUBSTANCE_NAME" -L -o /tmp/reg_echa.html
```

**Tips / 技巧 / Tipps**:
- GB standards: search `GB/T XXXXX-YYYY` or `GB XXXXX-YYYY` on CNKI or Sogou
- Regulation timelines: cross-reference effective dates with company annual report risk disclosures
- Policy signals: 发改委产业目录 (catalog of encouraged/restricted/eliminated industries) → investment direction
- Cross-jurisdiction: compare same product's regulatory pathway in US vs EU vs China for market access analysis

**Traps**: REG-01 (Chinese gov sites JS-rendered → use defuddle), REG-02 (policy docs in PDF → use W4 PyMuPDF), REG-03 (standard numbering differs: GB vs ISO vs ASTM — verify equivalence)

---

## Workflow W11: Supply Chain Mapping / 产业链映射 / Lieferkettenkartierung

End-to-end supply chain analysis: upstream raw materials, midstream processing/intermediates, downstream applications and end markets.
端到端产业链分析：上游原料、中游加工/中间体、下游应用与终端市场。
End-to-End-Lieferkettenanalyse: Rohstoffe (upstream), Verarbeitung/Zwischenprodukte (midstream), Anwendungen/Endmärkte (downstream).

**Research dimensions / 研究维度 / Forschungsdimensionen**:

```
Supply Chain Map / 产业链图谱 / Lieferkettenkarte
├─ UPSTREAM / 上游 / Vorgelagert
│   ├─ Raw materials / 原料: petrochemical feedstocks, biomass, minerals
│   ├─ Key suppliers / 核心供应商: concentration, geographic distribution
│   └─ Price drivers / 价格驱动: crude oil, crop yields, mining output
│
├─ MIDSTREAM / 中游 / Mittelstufe
│   ├─ Intermediates / 中间体: monomers, building blocks, APIs
│   ├─ Process technology / 工艺技术: synthesis routes, catalysts, yields
│   └─ Capacity / 产能: global nameplate vs operating rate, expansion plans
│
└─ DOWNSTREAM / 下游 / Nachgelagert
    ├─ Applications / 应用: end-use sectors, substitution threats
    ├─ Key customers / 核心客户: industry concentration, contract terms
    └─ Demand drivers / 需求驱动: GDP, regulation, consumer trends
```

**Data sources by layer / 按层级的数据源 / Datenquellen nach Ebene**:

| Layer / 层级 | Source / 源 | Method / 方法 |
|------|------|------|
| Raw material pricing / 原料价格 | 生意社 (100ppi.com), 卓创资讯, ICIS | Defuddle / Sogou |
| Supplier identification / 供应商识别 | Company annual reports (W4), industry association reports | PyMuPDF + keyword extraction |
| Production capacity / 产能 | Annual reports (W4), news (W6), industry yearbooks | Cross-validation |
| Trade flows / 贸易流向 | UN Comtrade, China Customs, ITC Trade Map | `curl` API / CSV download |
| Customer concentration / 客户集中度 | Annual report "top 5 customers" (W4), credit rating reports | PyMuPDF |
| Technology roadmap / 技术路线 | Patents (W7), literature review (W1), conference proceedings | Multi-source merge |

**Trade data / 贸易数据 / Handelsdaten**:

```bash
# UN Comtrade API (free tier, no key needed for basic)
curl -s "https://comtrade.un.org/api/get?max=20&type=C&freq=A&px=HS&ps=2024&r=156&p=all&rg=2&cc=AG2" \
  -o /tmp/comtrade_china_imports.json

# China Customs HS code lookup via Sogou / 海关HS编码查询
curl -s "https://www.sogou.com/web?query=HS%E7%BC%96%E7%A0%81+PRODUCT_NAME+%E8%BF%9B%E5%8F%A3" \
  -H "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36" \
  -L -o /tmp/hs_code_sogou.html
```

**Annual report supply chain extraction / 年报产业链提取**:

```python
# Extract supplier/customer sections from annual report (via W4 PyMuPDF output)
import re

with open('/tmp/pdf_output.txt', 'r', encoding='utf-8') as f:
    text = f.read()

# Chinese annual report patterns / 中文年报关键词
patterns = {
    'top5_customers': r'前五名客户.*?合计.*?(\d+\.?\d*%)',
    'top5_suppliers': r'前五名供应商.*?合计.*?(\d+\.?\d*%)',
    'capacity': r'(产能|产量|生产能力).*?(\d+\.?\d*)\s*(万吨|吨|t/a)',
    'raw_materials': r'主要原材料.*?((?:[一-鿿]+(?:、|，|,)){1,10})',
}

for key, pattern in patterns.items():
    matches = re.findall(pattern, text, re.DOTALL)
    if matches:
        print(f'\n=== {key} ===')
        for m in matches[:5]:
            print(f'  {str(m)[:200]}')
```

**Traps**: SCM-01 (annual report supplier lists may be redacted/aggregated), SCM-02 (HS codes ≠ company product categories), SCM-03 (news capacity figures vs annual report figures differ)

---

## Workflow W12: Industrial Clusters & Parks / 产业聚集区与产业园 / Industriecluster & Parks

Industrial cluster distribution, park policy comparison, infrastructure analysis, site selection, supply chain location analysis.
产业集群分布、园区政策对比、基础设施分析、企业选址、产业链区位分析。
Industriecluster-Verteilung, Parkpolitikvergleich, Infrastrukturanalyse, Standortwahl, Lieferketten-Standortanalyse.

**Research dimensions / 研究维度 / Forschungsdimensionen**:
- **Geography / 地理分布**: major industrial cluster maps worldwide
- **Policy / 产业政策**: national/provincial/park-level differentiated policies (tax, land, subsidies, talent)
- **Infrastructure / 园区特点**: facilities, supporting supply chain, environmental capacity, logistics
- **Tenants / 企业入驻**: anchor companies, upstream/downstream support, capacity concentration
- **International benchmarking / 国际对标**: cross-border park comparison

**Reference parks (public well-known cases) / 典型园区示例 / Referenzparks**:

| Country / 国家 | Park / 园区 | Type / 类型 | Features / 特点 |
|------|------|------|------|
| 🇩🇪 Germany | BASF Ludwigshafen | Chemical Verbund | Verbund integration model originator, 1865 founding, global largest single-company chem site |
| 🇩🇪 Germany | Frankfurt Höchst Industrial Park | Chemical/Pharma | Multi-tenant shared infrastructure, ~90 companies, 22,000 employees |
| 🇳🇱 Netherlands | Chemelot (Geleen) | Chemical/Innovation | 8,500+ employees, Brightlands innovation campus, top patent ranking |
| 🇧🇪 Belgium | Antwerp BASF Verbund | Chemical | BASF 2nd largest Verbund after Ludwigshafen, port-integrated |
| 🇸🇬 Singapore | Jurong Island | Chemical/Energy | Reclaimed island, pipeline network, global chemical hub, 100+ companies |
| 🇰🇷 South Korea | Ulsan Petrochemical Complex | Petrochemical/Auto | 5 industrial parks, Hyundai+SK+S-Oil, Saudi Aramco $7B Shaheen (1.8M t/a cracker) |
| 🇺🇸 USA | Houston Ship Channel | Petrochemical | Largest Gulf Coast petrochemical cluster, 150+ chemical plants |
| 🇨🇳 China | Shanghai Chemical Industry Park / 上海化学工业区 | Chemical | National-level, BASF/Huntsman/Covestro tenants, 29.4 km² |
| 🇨🇳 China | Nanjing Jiangbei New Materials S&T Park / 南京江北新材料科技园 | New Materials/Chemical | Top-ranked national chemical park, 45 km² |
| 🇨🇳 China | Huizhou Daya Bay / 惠州大亚湾石化区 | Petrochemical | Major refining+chemical integration zone, CNOOC/Shell JV |
| 🇨🇳 China | Ningbo Petrochemical Economic Development Zone / 宁波石化经济技术开发区 | Petrochemical | 中石化镇海炼化 base, largest refining-chemical integration in China |
| 🇨🇳 China | Taizhou China Medical City / 泰州中国医药城 | Biopharma | National-level medical hi-tech zone, vaccine industry cluster |
| 🇨🇳 China | Zhangjiang Pharma Valley / 张江药谷 | Biopharma | Innovation drug R&D cluster, MNC R&D centers, 400+ biotech companies |

**Search methods / 搜索方法 / Suchmethoden**:
- W6 Sogou: `[园区名] + 政策/入驻/产能` → domestic park info
- W10 Government/development zone official sites → policy documents
- OpenAlex: `"industrial park" + [industry]` → academic research (park efficiency / environmental impact)
- Google: `"[park name]" site:gov` → official policy files (VPN required)
- Annual reports → production site locations and capacity distribution

**Traps**: IPC-01 (park name confusion / 园区名称混淆), IPC-02 (reported vs actual operations / 报道 vs 实际运营)

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
| 14 | **比亚迪 × 中国科学院 cooperation** Sogou+OpenAlex | W6 enterprise news + W1 academic cross-validation | 7 OA + 3 Sogou news |
| 15 | **Global chemical park benchmarking** 10 parks | W12 cluster analysis + W6 news + W10 policy | 10 parks × 3 dimensions |
| 16 | **新和成 精细化工** vitamins/fragrance/flavors | W6 Sogou enterprise + W1 literature + W9 financials | 3 Sogou + 327 OA |
| 17 | **扬农化工 农用化学品** pesticide/agrochemical | W6 Sogou enterprise + W1 literature + W10 regulations | 3 Sogou + 24 OA |
| 18 | **伊利 食品科技** dairy/food ingredients/processing | W6 Sogou enterprise + W1 literature + W9 investment | 3 Sogou + 202 OA |
| 19 | **华熙生物 化妆品原料** hyaluronic acid/cosmetics | W6 Sogou enterprise + W1 literature + W7 patents | 3 Sogou + 119 OA |

### Multi-Direction Validation Details / 多方向验证详情 / Details der validierten Richtungen

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

Direction 5 / 方向5: BYD × CAS Cooperation / 比亚迪×中科院合作
  ├─ W6 Sogou: 3 news hits — solid-state battery cooperation signed 2024-11-21
  ├─ 中科院深圳先进院 + 比亚迪 = 新能源汽车前瞻技术项目合作协议
  ├─ Focus areas: solid-state batteries / lithium battery auxiliary materials / 固态电池+锂电辅材
  ├─ W1 OpenAlex BYD battery: 7 papers (max 16c) — few directly BYD-CAS co-authored
  ├─ W1 OpenAlex CAS battery: 10 papers (max 128c, "Beyond Lithium-Ion Batteries")
  └─ 🔑 Key insight: Cooperation is industrial R&D, NOT yet in academic publications
     → Validates SOG-02 (OpenAlex ≠ enterprise news) & W6 necessity for industry-academia tracking

Direction 6 / 方向6: Chemical Park Benchmarking / 全球化工园区对标
  ├─ 🇩🇪 BASF Ludwigshafen: Global largest single-company chemical site, 1865 Verbund origin
  ├─ 🇩🇪 Frankfurt Höchst: Multi-tenant shared infrastructure model
  ├─ 🇳🇱 Chemelot (Geleen): 8,500+ employees, innovation park, top patent ranking
  ├─ 🇧🇪 Antwerp: BASF 2nd largest Verbund, port-integrated, recent fire incident
  ├─ 🇸🇬 Jurong Island: Reclaimed island, 1828→2022 consolidation, global chem hub
  ├─ 🇰🇷 Ulsan: 5 industrial parks, Hyundai+SK+Saudi Aramco $7B Shaheen (1.8M t/a cracker)
  ├─ 🇺🇸 Houston Ship Channel: Largest Gulf Coast petrochemical cluster
  ├─ 🇨🇳 上海化工区: National-level, BASF/Huntsman/Covestro, photoresist 100t/a capacity
  ├─ 🇨🇳 惠州大亚湾: Petrochemical investment group, major refining+chemical zone
  └─ 🔑 Cross-cutting findings:
     ├─ Verbund/integration model: BASF origin → adopted by Jurong/Antwerp/上海
     ├─ Policy differentiation: National (🇨🇳) vs free-market cluster (🇺🇸) vs state-guided (🇸🇬🇰🇷)
     └─ New investment: Saudi Aramco $7B in Ulsan, photoresist capacity shift to 上海

Direction 7 / 方向7: Specialty Chemicals / 精细化工
  ├─ W6 Sogou: 3 news hits — 新和成 营养品/香精香料/高分子材料/原料药 四大板块
  ├─ Key products: 维生素A/E、香精香料、PPS高分子、医药中间体
  ├─ Capacity insight: 维生素产能利用率 50-60% (investor Q&A)
  ├─ W1 OpenAlex: 327 hits — biosurfactants (89c), functional foods (51c)
  └─ 🔑 Cross-source insight: Sogou reveals actual utilization rates not in academic literature
     → Validates W6 value for operational metrics vs W1 for scientific context

Direction 8 / 方向8: Agrochemicals / 农用化学品
  ├─ W6 Sogou: 3 news hits — 扬农化工 农药龙头, 菊酯中间体 9,000t/a, 草甘膦 30,000t/a
  ├─ 20-year listed history, capacity expansion-driven growth model
  ├─ W1 OpenAlex: 24 hits — biopesticides essential oils (157c), crop insurance (19c)
  ├─ W10 Regulatory: pesticide registration dynamics, China vs global regulatory pathways
  └─ 🔑 Key insight: Chinese agrochemical sector moving from generic → innovative formulation
     → Gap between enterprise capacity news (Sogou) and academic literature (OpenAlex)

Direction 9 / 方向9: Food Tech / 食品科技
  ├─ W6 Sogou: 3 news hits — 伊利 数智化转型, 高端婴幼儿配方奶粉, 精深加工技术
  ├─ Innovation: 乳糖不耐受解决方案, 控糖牛奶 (国内首款), 全球创新中心
  ├─ W1 OpenAlex: 202 hits — antimicrobial packaging (252c), e-nose/tongue (56c), ultrasound food tech (53c)
  ├─ W9 Investment: food tech VC/PE landscape, alternative protein funding trends
  └─ 🔑 Cross-domain overlap: Food ingredients ↔ bio-based materials (W1) ↔ fermentation (W11 supply chain)

Direction 10 / 方向10: Cosmetics Ingredients / 化妆品原料
  ├─ W6 Sogou: 3 news hits — 华熙生物 透明质酸龙头, 全产业链 (原料→终端)
  ├─ Competition: 焦点福瑞达 420t/a 透明质酸钠 (mainly non-pharma grade)
  ├─ W1 OpenAlex: 119 hits — microbial HA production (97c), HA comprehensive review (92c)
  ├─ W7 Patents: hyaluronic acid derivatives, cross-linked HA, delivery systems
  └─ 🔑 Key insight: Chinese HA makers dominate global supply (80%+ market share)
     → Shift from bulk raw material → functional ingredients → branded consumer products
```

---

## Traps Quick-Ref / 陷阱速查 / Fallen-Schnellreferenz

**53** cataloged traps across 16 categories.
**53** 个已知陷阱 (16类)。
**53** katalogisierte Fallen in 16 Kategorien.

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
| 🏭 Market/Capacity / 市场/产能 / Markt/Kapazität | W6 Sogou + defuddle + WebSearch + CNKI |
| 🔬 Patents / 专利 / Patente | Google Patents + CNKI patent database |
| 📏 Standards/Regulations / 标准/法规 / Normen | GB/T, ISO, EU, China plastic ban, FDA/EMA |
| 🔗 Supply Chain / 产业链 / Lieferkette | Industry reports + trade associations + annual reports |
| 🤖 AI+Industry / AI+产业 / KI+Industrie | OpenAlex + GS + W6 Sogou + W9 Investment (all industries) |
| 🧬 Biopharma / 生物制药 / Biopharma | OpenAlex + GS + CNKI (CHO/purification/AI/CGT/CDMO) |
| 💰 Investment / 投资分析 / Investment | W6 Sogou + AKShare + HKEX Scrape + SEC EDGAR + PyMuPDF |
| 📋 Regulatory / 法规政策 / Regulierung | National regulators + defuddle + CDP + W6 Sogou |
| 🏗️ Industrial Clusters / 产业聚集区 / Industriecluster | W6 Sogou + W10 Policy + Annual Reports + Government Sites |
| 🗺️ Enterprise News / 企业新闻 / Unternehmensnachrichten | W6 Sogou curl (Chinese) + WebSearch (English) |

---

## Reference Files / 参考文档 / Referenzdokumente

| File / 文件 / Datei | Content / 内容 / Inhalt |
|------|------|
| [[traps-catalog]] | 53 cataloged traps (16 categories) / 53个已知陷阱 / 53 Fallen |
| [[cnki-kns8-selectors]] | CNKI KNS8 DOM selectors / CNKI KNS8 DOM 选择器 / CNKI KNS8 DOM-Selektoren |
| [[scholar-chinese-citations]] | GS Chinese citation extraction / GS 中文引用提取 / GS Chinesische Zitationsextraktion |
| [[windows-utf8-fix]] | Windows UTF-8 permanent fix / Windows UTF-8 根治 / Windows UTF-8 permanente Lösung |
| [[pymupdf-industrial]] | PyMuPDF industrial PDF guide / PyMuPDF 工业 PDF 指南 / PyMuPDF Industrie-PDF-Anleitung |
| [[merge-dedup]] | Multi-source dedup & merge / 多源去重合并 / Multi-Quellen-Deduplizierung |
| [[annual-report-scraping]] | Annual report scraping (A-share/HKEX/US) / 上市公司报告爬取 / Geschäftsbericht-Scraping |

---

*synthon v0.3.0 · Built on academic-search · Validated on Windows 11*
*Chemical / Bio-Based / Polymer / Life Sciences Industry · 化工 / 生物基材料 / 聚合物 / 生命科学产业 · Chemie / Biobasierte Materialien / Polymer- / Biowissenschaften*
