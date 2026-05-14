# chemind

> 化工 / 生物基材料 / 聚合物 / 生命科学产业的多维度深度研究 Claude Code Skill

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Claude Code Skill](https://img.shields.io/badge/Claude%20Code-Skill-blue)](https://claude.ai)
[![Version](https://img.shields.io/badge/version-0.2.0-green)]()

[English](README.en.md) | [Deutsch](README.de.md)

---

## 定位

`chemind` 是 `academic-search` 的**化工材料与生命科学产业增强层**。不止于文献——整合市场数据、专利、标准、产能产量、产业链与 AI 驱动材料发现。

---

## 安装

### 环境要求

| 组件 | 最低版本 | 说明 |
|------|:---:|------|
| Python | 3.8+ | PyMuPDF 年报提取、数据去重 |
| Node.js | 18+ | CDP 浏览器控制（学术搜索核心依赖） |
| PowerShell | 7+ (**不是** 5.1) | PS 5.1 存在 UTF-8 编码 bug，中文必乱码 |
| Chrome / Chromium | 最新稳定版 | 远程调试模式（`chrome://inspect`） |

**平台支持**: Windows 11 ✅ | macOS ✅ | Linux ✅ (WSL2 推荐用于 Windows)

### 一键安装

```bash
bash <(curl -sL https://raw.githubusercontent.com/uranus421-glitch/chemind/master/install.sh)
```

自动完成：技能安装 → academic-search 依赖 → PyMuPDF → 环境检查

### 分步安装

```bash
# 1. 安装技能
npx skills install github:uranus421-glitch/chemind

# 2. 安装 CDP 基础设施
npx skills install github:uranus421-glitch/academic-search

# 3. 安装 Python 依赖
pip install PyMuPDF

# 4. 检查环境
bash ~/.claude/skills/chemind/scripts/check-env.sh
```

### 验证安装

在 Claude Code 中输入以下任一触发词即可激活：

> 化工产业研究 · 生物基材料调研 · 聚合物市场 · 上市公司年报 · 生物制药 · CDMO

---

## 覆盖维度

| 维度 | 工具/数据源 |
|------|------|
| 📚 学术文献 | OpenAlex + Google Scholar + CNKI 知网 |
| 📄 工业 PDF | PyMuPDF（年报 / 专利全文提取） |
| 🏭 市场与产能 | defuddle + WebSearch + CNKI |
| 🔬 专利 | Google Patents + CNKI 专利库 |
| 📏 标准与法规 | GB/T, ISO, EU, 限塑令, FDA/EMA |
| 🔗 产业链 | 研报 + 行业协会 + 年报 |
| 🤖 AI+材料 | OpenAlex + GS（ML 材料设计） |
| 🧬 生物制药 | OpenAlex + GS + CNKI（CHO/纯化/AI/CGT/CDMO） |

---

## 8 个工作流

| W# | 名称 | 数据源 | 用途 |
|----|------|--------|------|
| W1 | OpenAlex | REST API | 2023+ 最新论文 |
| W2 | Google Scholar CDP | CDP 浏览器（需 VPN） | 跨年代高引综述 |
| W3 | CNKI 知网 CDP | CDP 浏览器（**禁止 VPN**） | 中文全量 + 学位论文 |
| W4 | PyMuPDF | PDF 解析器 | 年报 / 专利全文提取 |
| W5 | 多源合并去重 | Python | 三源去重（DOI > 标题 > 标题+年份） |
| W6 | 产业情报 | defuddle + scrapling | 市场 / 产能 / 产业链 |
| W7 | 专利检索 | Google Patents + CNKI | 技术路线 / 竞争格局 |
| W8 | AI+材料 | OpenAlex + GS | ML 材料设计 / 聚合物信息学 |

---

## 已验证场景

| # | 场景 | 维度 | 数据量 |
|---|------|------|:---:|
| 1 | PA11/PA1010 长碳链生物基聚酰胺 三源检索 | 文献/专利预判/产业链/产能 | 50 篇 |
| 2 | 华峰化学 241 页年报 PyMuPDF 全量提取 | 工业 PDF/产能/财务/供应链 | 458 KB |
| 3 | RSC Lab on a Chip OA 论文 (44c 连续流) | 学术 OA/微流控纯化/智能下游 | 22 页 |
| 4 | Frontiers CGT 4.0 OA 论文 (4c) | 学术 OA/CGT/自动化传感器 | 6 页 |
| 5 | PHA 聚羟基脂肪酸酯 产业全景 | 文献/市场/降解标准/产能 | 85 篇 |
| 6 | AI + 聚合物材料设计 交叉前沿 | 文献/ML方法/材料信息学/产业 | 291 篇 |
| 7 | 生物基材料产业全景 三维交叉 | 3方向×10维度综合 | 60 篇 |
| 8 | Google Scholar 中文引用提取 | "被引用次数：133" 正则 | 全角冒号 Regex |
| 9 | CNKI 无 VPN 直连 CDP | KNS8 选择器 + SSL 绕过 | 140 条 |
| 10 | Windows 11 UTF-8 编码根治 | Python/PowerShell/Git Bash | 永久修复 |
| 11 | 生物制药产业全景 | 文献/工艺/AI/糖基化/CDMO | 41 篇 |
| 12 | WuXi Biologics 263 页年报 PyMuPDF | 工业 PDF/产能/财务/CDMO | 5 年财务表 |
| 13 | Samsung Biologics 财务验证 | 跨市场年报(港/韩) + Wikipedia | 2023-2024 |

---

## 已知陷阱（共 30 个，7 类）

1. `print()` 中文 → 崩溃（始终写 UTF-8 文件，不要 print 到控制台）
2. PS 5.1 而非 7+ → 编码错误（`[建议]` 被误解析为数组操作符）
3. CNKI + VPN → HTTP 418 封锁（CNKI 必须直连）
4. CDP `/navigate` 用于 CNKI → URL 参数被截断
5. GS 引用 Regex 无全角冒号 → 丢失所有中文界面结果
6. CNKI `.page-next` 失效 → 翻页静默失败
7. Google Scholar 无 VPN（国内）→ 网站不可达

完整目录 → [[traps-catalog]]

---

## 网络说明

- **CNKI 知网**：必须直连（VPN 触发 HTTP 418 反爬）
- **Google Scholar**（国内用户）：需 VPN，代理 `socks5h://127.0.0.1:10808`
- **国际用户**：所有数据源可直接访问
- **CDP 代理**：`http://127.0.0.1:3456`（Chrome 远程调试端口 `9222`）

---

## 触发词

化工产业研究 · 生物基材料调研 · 聚合物市场 · 产能产量 · 产业链分析 · 技术路线 · 竞争格局 · 材料专利 · AI材料设计 · 上市公司年报 · 生物制药 · 生物类似药 · 单抗 · ADC · 细胞基因治疗 · CHO培养 · CDMO

---

## 许可证

MIT — [LICENSE](LICENSE)

---

*chemind v0.2.0 · 化工 / 生物基材料 / 聚合物 / 生命科学*
