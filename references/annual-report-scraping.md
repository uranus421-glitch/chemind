# 上市公司报告爬取操作手册

## 化工·新材料·生物·AI 专版

---

## 第一章：市场分类与官方渠道

### 1.1 中国大陆 A 股（含北交所、新三板）

| 平台 | 网址 | 说明 | 适用领域 |
|------|------|------|----------|
| **巨潮资讯网** | www.cninfo.com.cn | 证监会指定披露平台，所有A股强制同步 | 化工、新材料、生物、AI全覆盖 |
| 上交所 | www.sse.com.cn | 沪市主板/科创板 | AI、新材料（科创板集中） |
| 深交所 | www.szse.cn | 深市主板/创业板 | 生物、新材料（创业板集中） |
| 北交所 | www.bse.cn | 专精特新企业 | 新材料、化工细分龙头 |

**API 端点：**
```bash
POST http://www.cninfo.com.cn/new/hisAnnouncement/query
# 关键参数：
#   category=category_ndbg_szsh  # 年报
#   category=category_bndbg_szsh # 半年报
#   category=category_yjdbg_szsh   # 一季报
#   category=category_sjdbg_szsh   # 三季报
#   seDate=2023-01-01~2024-12-31 # 日期区间
#   stock=000001,9900016933      # 股票代码,orgId
```

### 1.2 香港上市（主板 + GEM）

| 平台 | 网址 | 说明 | 适用领域 |
|------|------|------|----------|
| **披露易（HKEXnews）** | www.hkexnews.hk | 港交所官方披露平台 | 港股化工（中石化、万华化学H）、生物药（药明、百济） |

**搜索页：**
```bash
https://www1.hkexnews.hk/search/titlesearch.xhtml?lang=zh
# 限制：超12个月需选具体股份，每页最多100条
```

### 1.3 美国上市（含中概股）

| 平台 | 网址 | 说明 | 适用领域 |
|------|------|------|----------|
| **SEC EDGAR** | www.sec.gov/edgar | 美国证监会官方系统 | 中概股生物（百济、再鼎）、AI（英伟达、AMD） |

**关键文件类型：**

| 代码 | 含义 | 适用 |
|------|------|------|
| 10-K | 年报 | 美国本土公司 |
| 10-Q | 季报 | 美国本土公司 |
| 20-F | 非美国注册公司年报 | **中概股常用** |
| 8-K | 重大事项 | 并购、专利授权 |
| 13D | 大股东变动 | 战略投资 |

**EDGAR 官方 API：**
```bash
# 公司搜索
https://www.sec.gov/cgi-bin/browse-edgar?action=getcompany&CIK=0001018724&type=20-F&dateb=&owner=include&count=40

# 每日索引
https://www.sec.gov/Archives/edgar/daily-index/
```

---

## 第二章：GitHub 开源工具库（按市场分类）

### 2.1 A 股工具

| 项目名称 | GitHub 地址 | 功能 | 星标 | 适用领域 |
|----------|-------------|------|------|----------|
| **AKShare** | https://github.com/akfamily/akshare | 财经数据接口库，含巨潮资讯公告接口 | 9.6k | 全行业 |
| **scrape-cop-reports-CnInfo** | https://github.com/scrape-cop-reports-CnInfo | 批量下载年报、季报、CSR报告 | - | 化工ESG、新材料 |
| **cninfo-reports** | https://github.com/cninfo-reports | 巨潮资讯网报告爬取 | - | 全行业 |
| **stock-spider** | https://github.com/stock-spider | 股票数据爬虫 | - | AI量化 |

**AKShare 公告接口示例：**
```python
import akshare as ak

# 获取个股公告
df = ak.stock_notice_report(symbol="000001", date="20231231")
# 获取年报
df = ak.stock_yjbb_em(date="20231231")  # 业绩快报
```

### 2.2 港股工具

| 项目名称 | GitHub 地址 | 功能 | 星标 | 适用领域 |
|----------|-------------|------|------|----------|
| **ScrapeHKEX** | https://github.com/ScrapeHKEX | 港股 ESG 报告爬取，可扩展至年报 | - | 化工ESG、生物药 |
| **hkexnews-spider** | https://github.com/hkexnews-spider | 披露易公告爬取 | - | 全行业 |

### 2.3 美股/EDGAR 工具

| 项目名称 | GitHub 地址 | 功能 | 星标 | 适用领域 |
|----------|-------------|------|------|----------|
| **secedgar** | https://github.com/sec-edgar/sec-edgar | SEC EDGAR 数据下载，支持CIK查询 | 1.2k | 中概股生物、AI |
| **edgar-crawler** | https://github.com/edgar-crawler | EDGAR 文件批量爬取 | - | 全行业 |
| **sec-api** | https://github.com/sec-api | SEC API 封装 | - | 量化分析 |

**secedgar 使用示例：**
```python
from secedgar import filings, FilingType

# 下载苹果年报
my_filings = filings(cik_lookup="aapl",
                     filing_type=FilingType.FILING_10K,
                     user_agent="Your Name (email@example.com)")
my_filings.save('/path/to/dir')
```

### 2.4 跨市场/通用工具

| 项目名称 | GitHub 地址 | 功能 | 星标 | 适用领域 |
|----------|-------------|------|------|----------|
| **Tushare** | https://github.com/waditu/tushare | 中文财经数据接口，含财报数据 | 12k | 全行业 |
| **Baostock** | https://github.com/baostock | 免费股票数据，含季频财务数据 | - | 量化研究 |
| **OpenBB-finance** | https://github.com/OpenBB-finance/OpenBBTerminal | 开源金融终端，整合多源数据 | 25k | 投研分析 |
| **yfinance** | https://github.com/ranaroussi/yfinance | Yahoo Finance 数据获取 | 11k | 美股AI、生物 |

---

## 第三章：行业专项数据源

### 3.1 化工行业

| 数据源 | 类型 | 网址/说明 | 爬取价值 |
|--------|------|-----------|----------|
| **中国化工信息中心** | 行业数据 | www.chemchina.com.cn | 行业景气指数 |
| **卓创资讯** | 大宗商品 | www.sci99.com | 化工品价格数据 |
| **百川盈孚** | 行业数据 | www.baiinfo.com | 产能、开工率 |
| **化工企业 ESG 报告** | 巨潮/披露易 | 万华化学、中石化、荣盛石化 | 碳排放、能耗数据 |

**化工行业重点关注指标（年报中）：**
- 产能利用率、在建工程转固进度
- 原材料成本占比（原油、煤炭、天然气）
- 环保投入、碳排放强度（ESG报告）
- 新材料业务营收占比（转型信号）

### 3.2 新材料行业

| 数据源 | 类型 | 网址/说明 | 爬取价值 |
|--------|------|-----------|----------|
| **新材料在线** | 行业平台 | www.cailiaoxia.com | 行业研报 |
| **中国材料研究学会** | 学术/行业 | www.c-mrs.org.cn | 技术路线 |
| **科创板/北交所** | 交易所 | 上交所/北交所 | 半导体材料、锂电材料、碳纤维 |
| **专利数据库** | 知识产权 | 国家知识产权局 | 技术壁垒分析 |

**新材料行业重点关注指标：**
- 研发投入占比（通常>10%）
- 专利数量及授权率
- 客户认证进度（半导体材料关键）
- 进口替代比例

### 3.3 生物行业（制药+生物科技）

| 数据源 | 类型 | 网址/说明 | 爬取价值 |
|--------|------|-----------|----------|
| **CDE（药品审评中心）** | 监管数据 | www.cde.org.cn | 临床试验、上市审批 |
| **药智网** | 行业数据 | db.yaozh.com | 药品注册、一致性评价 |
| **Insight 数据库** | 医药数据 | insight.chemicalbook.com | 全球管线 |
| **FDA 数据库** | 监管数据 | www.fda.gov | 海外申报进度 |
| **ClinicalTrials.gov** | 临床数据 | clinicaltrials.gov | 全球临床试验 |

**生物行业重点关注指标：**
- 管线进展（临床I/II/III期）
- 核心产品销售额（商业化能力）
- 医保谈判/集采影响
- 研发人员占比、博士占比

### 3.4 AI 行业

| 数据源 | 类型 | 网址/说明 | 爬取价值 |
|--------|------|-----------|----------|
| **GitHub** | 代码/项目 | github.com | 开源项目热度 |
| **Papers With Code** | 学术/工程 | paperswithcode.com | SOTA模型跟踪 |
| **Crunchbase** | 商业数据 | www.crunchbase.com | 融资情况 |
| **IT桔子** | 投资数据 | www.itjuzi.com | 国内AI融资 |
| **科创板/美股** | 交易所 | 上交所/纳斯达克 | 商汤、科大讯飞、英伟达 |

**AI 行业重点关注指标：**
- 算力投入（资本开支中GPU占比）
- 模型训练成本、推理成本
- 客户数、ARR（年度经常性收入）
- 数据资产规模、标注成本

---

## 第四章：实战操作手册

### 4.1 A 股年报批量下载（化工行业示例）

```python
import requests
import json
import os
import time

# 配置
SAVE_DIR = "./reports/chemical/"
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36",
    "Content-Type": "application/x-www-form-urlencoded; charset=UTF-8",
    "X-Requested-With": "XMLHttpRequest"
}

# 化工行业部分股票代码（示例）
CHEMICAL_STOCKS = [
    "600309",  # 万华化学
    "600028",  # 中国石化
    "002493",  # 荣盛石化
    "600346",  # 恒力石化
    "002812",  # 恩捷股份（新材料）
    "300014",  # 亿纬锂能（新材料）
]

def get_annual_reports(stock_code, start_date="2023-01-01", end_date="2024-12-31"):
    url = "http://www.cninfo.com.cn/new/hisAnnouncement/query"
    data = {
        "pageNum": "1",
        "pageSize": "30",
        "tabName": "fulltext",
        "column": "sse" if stock_code.startswith("6") else "szse",
        "category": "category_ndbg_szsh",
        "seDate": f"{start_date}~{end_date}",
        "stock": f"{stock_code},",
        "searchkey": "",
        "secid": "",
        "sortName": "",
        "sortType": "",
        "limit": "",
        "pageId": "1"
    }
    try:
        resp = requests.post(url, data=data, headers=HEADERS, timeout=30)
        result = resp.json()
        if result.get("announcements"):
            return result["announcements"]
        return []
    except Exception as e:
        print(f"Error fetching {stock_code}: {e}")
        return []

def download_report(adjunct_url, filename, stock_code):
    base_url = "https://static.cninfo.com.cn/"
    full_url = base_url + adjunct_url
    try:
        resp = requests.get(full_url, headers=HEADERS, timeout=60)
        if resp.status_code == 200:
            stock_dir = os.path.join(SAVE_DIR, stock_code)
            os.makedirs(stock_dir, exist_ok=True)
            filepath = os.path.join(stock_dir, filename)
            with open(filepath, "wb") as f:
                f.write(resp.content)
            print(f"Downloaded: {filename}")
            return True
    except Exception as e:
        print(f"Error downloading {filename}: {e}")
    return False

def main():
    for stock in CHEMICAL_STOCKS:
        print(f"\nProcessing: {stock}")
        reports = get_annual_reports(stock)
        for report in reports:
            title = report.get("announcementTitle", "")
            if "年度报告" in title and "摘要" not in title and "修订" not in title:
                adjunct_url = report.get("adjunctUrl", "")
                if adjunct_url:
                    filename = f"{stock}_{report.get('announcementId')}.pdf"
                    download_report(adjunct_url, filename, stock)
                    time.sleep(2)

if __name__ == "__main__":
    main()
```

### 4.2 港股 ESG 报告爬取（生物/化工示例）

```python
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import Select
import time
import os

HK_STOCKS = [
    "02359",  # 药明康德
    "01898",  # 中煤能源（化工）
    "00386",  # 中石化
    "01171",  # 兖矿能源
]

def download_hkex_esg(stock_code, save_dir="./reports/hkex/"):
    url = "https://www1.hkexnews.hk/search/titlesearch.xhtml?lang=zh"
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    options.add_experimental_option("prefs", {
        "download.default_directory": os.path.abspath(save_dir),
        "download.prompt_for_download": False,
    })
    driver = webdriver.Chrome(options=options)
    try:
        driver.get(url)
        time.sleep(3)
        stock_input = driver.find_element(By.ID, "searchStockCode")
        stock_input.send_keys(stock_code)
        category_select = Select(driver.find_element(By.ID, "titleCategory"))
        category_select.select_by_value("6")
        search_btn = driver.find_element(By.ID, "btnSearch")
        search_btn.click()
        time.sleep(5)
        rows = driver.find_elements(By.CSS_SELECTOR, "table.resultTable tr")
        for row in rows[1:]:
            try:
                link = row.find_element(By.CSS_SELECTOR, "a[href*='.pdf']")
                pdf_url = link.get_attribute("href")
                title = link.text
                if "ESG" in title or "环境" in title or "社会责任" in title:
                    driver.get(pdf_url)
                    time.sleep(3)
                    print(f"Downloaded ESG report for {stock_code}: {title}")
            except:
                continue
    finally:
        driver.quit()

for stock in HK_STOCKS:
    download_hkex_esg(stock)
    time.sleep(5)
```

### 4.3 SEC EDGAR 中概股生物/AI 年报爬取

```python
from secedgar import filings, FilingType
import os

COMPANIES = {
    "BGNE": "0001651308",  # 百济神州
    "ZLAB": "0001738941",  # 再鼎医药
    "BEKE": "0001803404",  # 贝壳（AI应用）
    "BIDU": "0001329099",  # 百度（AI）
    "TME": "0001744489",   # 腾讯音乐（AI应用）
}

def download_edgar_20f(cik, company_name, save_dir="./reports/edgar/"):
    company_dir = os.path.join(save_dir, company_name)
    os.makedirs(company_dir, exist_ok=True)
    try:
        my_filings = filings(
            cik_lookup=cik,
            filing_type=FilingType.FILING_20F,
            user_agent="Your Name (your.email@example.com)"
        )
        my_filings.save(company_dir)
        print(f"Downloaded 20-F for {company_name}")
    except Exception as e:
        print(f"Error downloading {company_name}: {e}")

for ticker, cik in COMPANIES.items():
    download_edgar_20f(cik, ticker)
```

### 4.4 行业数据整合（化工+新材料）

```python
import akshare as ak
import pandas as pd

def get_chemical_industry_data():
    stocks = ak.stock_board_industry_name_em()
    chemical_stocks = stocks[stocks["板块名称"].str.contains("化工|化学|材料")]
    financial_data = []
    for _, row in chemical_stocks.head(10).iterrows():
        try:
            code = row["板块代码"]
            fin = ak.stock_financial_analysis_indicator(symbol=code)
            financial_data.append(fin)
        except:
            continue
    return pd.concat(financial_data, ignore_index=True)

df = get_chemical_industry_data()
df.to_csv("chemical_financial_data.csv", index=False)
```

---

## 第五章：数据存储与结构化

### 5.1 推荐存储方案

| 数据类型 | 存储方案 | 说明 |
|----------|----------|------|
| 原始 PDF | 对象存储（OSS/S3） | 按 `市场/行业/股票代码/年份/` 分级 |
| 结构化财务数据 | PostgreSQL / MySQL | 标准化报表科目 |
| 文本内容（NLP分析） | Elasticsearch | 支持全文检索 |
| 时序数据（股价+财务） | InfluxDB / TimescaleDB | 量化分析 |
| 非结构化数据 | MongoDB | ESG报告、新闻舆情 |

### 5.2 目录结构建议

```
/reports/
├── cn/
│   ├── chemical/
│   │   ├── 600309_万华化学/
│   │   │   ├── 2023_年报.pdf
│   │   │   ├── 2023_ESG报告.pdf
│   │   │   └── 2024_半年报.pdf
│   │   └── 600028_中国石化/
│   ├── new_material/
│   │   ├── 002812_恩捷股份/
│   │   └── 300014_亿纬锂能/
│   ├── biotech/
│   │   ├── 688180_君实生物/
│   │   └── 688235_百济神州/
│   └── ai/
│       ├── 688256_寒武纪/
│       └── 002230_科大讯飞/
├── hk/
│   ├── 02359_药明康德/
│   └── 01898_中煤能源/
└── us/
    ├── BGNE_百济神州/
    ├── ZLAB_再鼎医药/
    └── BIDU_百度/
```

---

## 第六章：合规与注意事项

### 6.1 法律合规清单

| 平台 | 限制 | 建议 |
|------|------|------|
| 巨潮资讯网 | 无明确频率限制，但大量请求可能触发验证码 | 单IP每秒<=2请求，使用代理池 |
| 披露易 | 需模拟浏览器行为 | 使用 Selenium + 随机延迟 |
| SEC EDGAR | **强制要求**请求头含 User-Agent 和邮箱 | 遵守 Fair Access 政策，非高峰时段请求 |
| 各交易所 | 数据仅供研究，禁止商用转售 | 注明数据来源，仅用于分析 |

### 6.2 反爬应对

```python
# 代理池配置
PROXY_POOL = [
    "http://user:pass@proxy1:8080",
    "http://user:pass@proxy2:8080",
]

# 随机延迟
import random
time.sleep(random.uniform(1, 3))

# 请求头轮换
USER_AGENTS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64)...",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)...",
]
```

---

## 第七章：进阶应用

### 7.1 NLP 分析 pipeline

```python
import pdfplumber
from transformers import pipeline

# 1. PDF 转文本
def pdf_to_text(filepath):
    text = ""
    with pdfplumber.open(filepath) as pdf:
        for page in pdf.pages:
            text += page.extract_text() or ""
    return text

# 2. 关键信息提取
ner = pipeline("ner", model="shibing624/macbert4cner-base-chinese")
text = pdf_to_text("2023_年报.pdf")
entities = ner(text[:1000])

# 3. 情感分析（ESG部分）
sentiment = pipeline("sentiment-analysis", model="uer/roberta-base-finetuned-jd-binary-chinese")
esg_text = extract_esg_section(text)
result = sentiment(esg_text)
```

### 7.2 化工行业专项监控

| 监控目标 | 数据源 | 触发条件 |
|----------|--------|----------|
| 产能扩张公告 | 巨潮"募投项目"公告 | 关键词"新建""扩建""产能" |
| 原材料价格异动 | 卓创资讯 API | 周涨幅>10% |
| 环保处罚 | 巨潮"重大事项" | 关键词"环保""处罚""整改" |
| 专利授权 | 国家知识产权局 | 核心专利法律状态变更 |
| FDA/EMA 审批 | SEC 8-K / CDE | 临床/上市进展 |

---

## 附录：快速参考表

| 需求 | 首选工具 | 备用方案 |
|------|----------|----------|
| A股年报批量下载 | scrape-cop-reports-CnInfo | AKShare + 自建脚本 |
| 港股ESG报告 | ScrapeHKEX | Selenium 自建 |
| 中概股20-F | secedgar | SEC官方API |
| 实时财务数据 | Tushare Pro | AKShare |
| 跨市场分析 | OpenBB Terminal | Bloomberg API（付费） |
| 化工价格数据 | 卓创资讯API | 百川盈孚 |
| 生物管线数据 | Insight数据库 | 药智网 |
| AI融资数据 | IT桔子API | Crunchbase |

---

*手册版本：v1.0*  
*适用领域：化工、新材料、生物、AI*  
*覆盖市场：A股、港股、美股（含中概股）*
