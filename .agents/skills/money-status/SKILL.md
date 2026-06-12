---
name: money-status
description: cheat-on-money skill 的状态看板。显示用户画像、候选机会及其反诈判定、当前在执行的机会与进度、复盘记录、建议的下一步。无副作用，任何时候可调。触发词："搞钱状态"/"我现在的进度"/"看板"/"money status"/"我现在该做什么"。
argument-hint: ""
allowed-tools: Bash(*), Read, Glob, Skill
---

# /money-status — 状态看板

只读，不改任何东西。汇总当前进展并给出下一步建议。

## 流程

### Step 1 — 读状态
```bash
test -f .money-state.json && echo OK || echo MISSING
```
- MISSING → 提示先走 `money-init`。
- OK → 读取并展示。

### Step 2 — 展示
- **画像 + 段位**：当前 `tier`（T0–T3）及理由 / 技能 / 周可投入时间 / 启动资金 / 地区 / 露脸。
- **已沉淀经验**：若有 `lessons.md`，摘要"对我有效 / 亲历坑"几条。
- **候选机会**：按 可行 ✅ / 存疑 ⚠️ / 高危 ❌ 分组列出，每个标"钱从哪来"。
- **正在执行**：chosen 机会 + 开始日期 + plan 的验证第一步是否已完成。
- **复盘记录**：retro_log 摘要（投入/收入/结论/教训）。

### Step 3 — 建议下一步
根据状态智能路由：
- 没有候选 → "帮我找机会"（money-find）
- 有存疑机会没查清 → "验证 XX"（money-verify）
- 有可行机会没选 → "我想做 XX 帮我做计划"（money-plan）
- 有在执行的机会 → 到验证节点/T+N 天 → "复盘 XX"（money-retro）

结尾带一句 rubric E 的清醒剂，提醒护城河来自技能积累而非项目本身。
