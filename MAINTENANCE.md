# chemind 维护面板

> 改代码 → 推送 → 同步 vault 的循环操作手册

## 目录速查

| 路径 | 角色 | Git？ |
|------|------|:--:|
| `~/dev/chemind/` | 📝 **源仓库** — 在这改 | ✅ |
| `.agents/skills/chemind/` | 📦 **安装副本** — AI 运行时读取 | ❌ |
| `github.com/uranus421-glitch/chemind` | ☁️ **远程** — 分发源 | — |

## 标准更新循环

```
编辑 ~/dev/chemind/ 下的文件
        ↓
  git add -A
  git commit -m "..."
  git push origin master
        ↓
  npx skills install github:uranus421-glitch/chemind
        ↓
  .agents/skills/chemind/ 同步到最新 ✅
```

## 快速命令

```bash
# === 改完代码后 ===
cd ~/dev/chemind
git add -A
git commit -m "描述改动"
git push origin master

# === 同步 vault ===
cd ~/xinku   # 或 vault 目录
npx skills install github:uranus421-glitch/chemind

# === 看状态 ===
cd ~/dev/chemind && git status
cd ~/dev/chemind && git log --oneline -5
```

## 改了哪些文件

| 文件 | 内容 | 改完要更新 |
|------|------|:--:|
| `SKILL.md` | 主技能：工作流、陷阱、触发词 | ✅ |
| `README.md` | GitHub 首页（三语） | ✅ |
| `README.en.md` | 英文版 | 按需 |
| `README.de.md` | 德文版 | 按需 |
| `scripts/check-env.sh` | 环境检查 | ✅ |
| `references/*.md` | 陷阱目录、选择器速查等 | ✅ |
| `install.sh` | 一键安装脚本 | ✅ |
| `package.json` | 包元数据 | ⚠️ 改版本号时 |

## 注意事项

- **不要**直接改 `.agents/skills/chemind/` — 它不是仓库，install 会覆盖
- 所有修改在 `~/dev/chemind/` 完成
- push 后记得跑 `npx skills install` 同步 vault 副本
- 改 `SKILL.md` 的 `name:` 或 `version:` 后两端同步验证
