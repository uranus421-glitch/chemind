# deep-lit — 化工材料产业文献深度研究 Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.1.0-green)]()

**Claude Code Skill for chemical/materials industrial literature research.**
基于 `academic-search` 的化工材料产业文献深度研究增强层。

---

## 定位

`deep-lit` **不是** `academic-search` 的替代品，而是它的**化工材料领域增强层**：

- `academic-search` → 通用学术搜索基础设施（CDP proxy、API cookbook、多平台矩阵）
- `deep-lit` → 化工材料产业研究的**实战操作手册**（具体命令、28个已知陷阱、中文特殊处理、工业 PDF 流程）

## 为什么需要 deep-lit？

| 场景 | academic-search | deep-lit |
|------|:---:|:---:|
| 通用学术文献搜索 | ✅ | — |
| 聚合物/生物基材料专题检索 | — | ✅ |
| CNKI 知网 KNS8 DOM 选择器 | — | ✅ |
| Google Scholar 中文引用提取 | — | ✅ |
| Windows UTF-8 编码根治 | — | ✅ |
| 工业 PDF（年报/专利）提取 | — | ✅ |
| 28 个已知陷阱完全目录 | — | ✅ |
| 中英双语文献合并去重 | — | ✅ |

## 快速开始

```bash
# 安装
npx skills install github:uranus421/deep-lit

# 验证
npx skills list | grep deep-lit

# 环境检查
bash scripts/check-env.sh
```

### 前置依赖

```bash
# 1. academic-search（CDP 基础设施）
npx skills install github:uranus421/academic-search

# 2. Python 依赖
pip install PyMuPDF

# 3. Node.js 22+
node --version
```

## 触发词

在 Claude Code 对话中提到以下内容自动激活：

- "搜索 XX 材料/化工 文献"、"XX 文献综述"
- "查 XX 知网"、"找 XX 论文"
- "产业研究"、"技术调研"、"文献调研"
- "提取年报"、"PDF 全文"
- 涉及 PA/PE/PP/PU/PET/PLA 等聚合物、生物基材料、化工产业链

## 工作流

| 工作流 | 检索源 | 说明 |
|--------|--------|------|
| **W1** | OpenAlex API | 2023+ 最新英文论文，OA 状态判定 |
| **W2** | Google Scholar CDP | 跨年代高引综述，引用数权威 |
| **W3** | CNKI 知网 CDP | 中文全量 + 学位论文 |
| **W4** | PyMuPDF | 年报/专利 PDF 全文提取 |
| **W5** | Python merge | 三源合并去重 |

## 目录结构

```
deep-lit/
├── SKILL.md                         # 主技能文件
├── README.md                        # 本文件（中文）
├── README.en.md                     # English documentation
├── LICENSE                          # MIT
├── .gitignore
├── references/
│   ├── traps-catalog.md             # 28 个已知陷阱（按平台分组）
│   ├── cnki-kns8-selectors.md       # 知网 KNS8 DOM 选择器速查
│   ├── scholar-chinese-citations.md # Google Scholar 中文引用提取
│   ├── windows-utf8-fix.md          # Windows UTF-8 环境根治方案
│   ├── pymupdf-industrial.md        # PyMuPDF 工业 PDF 提取指南
│   └── merge-dedup.md               # 多源去重合并代码
└── scripts/
    └── check-env.sh                 # 环境检查脚本
```

## 已验证场景

- ✅ PA11/PA1010 长碳链生物基聚酰胺三源文献检索
- ✅ 华峰化学 241 页年报 PyMuPDF 全量提取
- ✅ Google Scholar 中文引用数 "被引用次数：133" 提取
- ✅ CNKI KNS8 CAPTCHA / SSL / location.href 全链路打通
- ✅ Windows 11 Git Bash + PowerShell 7+ UTF-8 编码根治

## 迭代路线

- **v0.1.0** ← 当前：4 个工作流 + 28 个陷阱 + 6 个 reference
- **v0.2.0**：补充化工行业站点模式（chemnews、ccfa 等）
- **v0.3.0**：添加专利检索工作流（Google Patents CDP）
- **v1.0.0**：用户反馈稳定 + 至少 3 次实战验证

## 许可证

MIT — 详见 [LICENSE](LICENSE)

---

*Made for real chemical/materials industry research. Not academic in theory — validated in production.*
