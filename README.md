# deep-chem — 化工与生物基材料产业深度研究 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

**化工 / 生物基材料 / 聚合物产业的多维度深度研究 Claude Code Skill。**

不止于文献——整合市场数据、专利、标准、产能产量、产业链、AI 材料设计。

Built on `academic-search` for CDP infrastructure.

## 定位

`deep-chem` 是 `academic-search` 的**化工材料产业增强层**：

- `academic-search` → 通用学术搜索基础设施
- `deep-chem` → 化工材料产业**多维度研究操作手册**（文献 + 专利 + 市场 + 产能 + 产业链 + AI+材料）

## 覆盖维度

| 维度 | 工具/数据源 | 说明 |
|------|-----------|------|
| 📚 学术文献 | OpenAlex + Google Scholar + CNKI | 中英文双源，三源合并去重 |
| 📄 工业 PDF | PyMuPDF | 年报、专利全文提取 |
| 🏭 市场/产能 | defuddle + WebSearch | 行业新闻、产能数据、市场价格 |
| 🔬 专利 | Google Patents + CNKI 专利库 | 技术路线、竞争格局 |
| 📏 标准/法规 | 国家标准网 + ISO | 行业标准检索 |
| 🔗 产业链 | 研报 + 行业协会 | 上下游分析 |
| 🤖 AI+材料 | OpenAlex + GS | ML 驱动材料设计、聚合物信息学 |

## 快速开始

```bash
npx skills install github:uranus421-glitch/deep-chem

# 环境检查
bash scripts/check-env.sh

# 前置依赖
pip install PyMuPDF
npx skills install github:uranus421-glitch/academic-search
```

## 触发词

- "化工产业研究"、"生物基材料调研"、"聚合物市场"
- "产能产量"、"产业链分析"、"技术路线"、"竞争格局"
- "材料专利"、"AI 材料设计"、"聚合物信息学"
- "上市公司年报"、"行业标准"

## 工作流（8 个）

| W# | 名称 | 数据源 | 覆盖维度 |
|----|------|--------|----------|
| W1 | OpenAlex | API | 2023+ 最新英文论文 |
| W2 | Google Scholar CDP | CDP 浏览器 | 跨年代高引综述 |
| W3 | CNKI 知网 CDP | CDP 浏览器 | 中文全量 + 学位论文 |
| W4 | PyMuPDF | PDF 解析 | 年报/专利全文提取 |
| W5 | 多源合并去重 | Python | 三源去重排序 |
| W6 | 产业情报 | defuddle + scrapling | 市场/产能/产业链 |
| W7 | 专利检索 | Google Patents + CNKI | 技术路线/竞争格局 |
| W8 | AI+材料 | OpenAlex + GS | ML 材料设计 |

## 已验证场景

- ✅ PA11/PA1010 生物基聚酰胺三源文献检索（50 篇合并）
- ✅ 华峰化学 241 页年报 PyMuPDF 全量提取
- ✅ CNKI 无 VPN 直连全链路打通（KNS8 选择器验证）
- ✅ Google Scholar 中文引用提取（"被引用次数：133"）
- ✅ Windows 11 UTF-8 编码永久根治

## 参考文档

| 文档 | 内容 |
|------|------|
| [[traps-catalog]] | 28 个已知陷阱（7 类） |
| [[cnki-kns8-selectors]] | 知网 KNS8 DOM 选择器 |
| [[scholar-chinese-citations]] | GS 中文引用提取 |
| [[windows-utf8-fix]] | Windows UTF-8 根治 |
| [[pymupdf-industrial]] | PyMuPDF 工业 PDF 指南 |
| [[merge-dedup]] | 多源去重合并 |

## 许可证

MIT — [LICENSE](LICENSE)
