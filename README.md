# 分拆任务 · Task Split — Cloud/Local Intelligence Layering Skill

[中文](#中文说明) | [English](#english)

---

## 中文说明

### 这是什么

**分拆任务（task-split）** 是一个 AI Agent 技能（Hermes Agent / 兼容 SKILL.md 规范的各类 Agent CLI），用于把**高复杂度、高 token 消耗**的任务拆成两层执行：

- 🟢 **低智能重复工作**（重复计算、比对、检索、分类、校验、排版、誊抄）→ **下沉到本地执行**，几乎不消耗云端 token
- 🔴 **高智能工作**（汇总、归因、判断、决策、创作）→ 只把**浓缩成果**回传云端大模型处理

一句话口诀：**苦力下基层，智慧留中枢；数据不出门，结论坐飞机。**

### 为什么需要它

云端大模型按 token 计费。实际任务中 80% 以上的 token 往往浪费在"苦力活"上：把几千行数据贴进对话、让模型逐条比对、重复格式化……这些工作用确定性脚本在本地做，成本为零、速度更快、结果更可复现。本技能把这种工作方式**制度化**：拆分 → 下沉 → 本地执行 → 浓缩回传，四步闭环。

### 功能特性

| 功能 | 说明 |
|------|------|
| 触发方式 | 对 Agent 说「分拆任务」或「减少 token 消耗」即启动 |
| 智能分级矩阵 | 内置 🟢/🔴 决策表 + 分级铁律，逐项判定子任务归属 |
| 四步闭环流程 | ①拆分清单 ②规范文件下沉 ③本地批量执行 ④浓缩回传汇总 |
| 跨领域模板 | 批量数据处理 / 大规模检索比对 / 文档排版誊抄 / 周期分析 / 代码日志审查 |
| 红线机制 | 诚实红线（禁止隐瞒异常）、安全红线（不碰 secrets）、抽样校验闭环 |
| 资产沉淀 | 可复用脚本与规范落盘，同类任务复用零成本 |

### 使用要求

1. 一个支持 SKILL.md 技能的 Agent 环境（Hermes Agent 最佳；Claude Code / Kimi CLI 等亦可参考使用）
2. 本地具备基础执行能力：Python3（建议含 pandas/numpy）、curl/jq、grep/ripgrep
3. 安装：将 `SKILL.md` 放入 Agent 技能目录（如 `~/.hermes/skills/workflow/task-split/`），Agent 自动发现

### 自由评判与反馈

本技能**开放给所有人自由使用、评判和反馈** 🎉

- 觉得哪里设计不合理？规则分级有不同看法？有实际使用中的节省数据？
- 欢迎直接开 **Issue** 分享你的评判、改进建议或实测效果
- 也欢迎 **Pull Request** 贡献场景模板和分级规则
- 无论好评差评，真实反馈都是最好的礼物

---

## English

### What is this

**Task Split** is an AI-agent skill (designed for Hermes Agent; compatible with any agent CLI following the SKILL.md convention) that splits **high-complexity, high-token-consumption** tasks into two execution layers:

- 🟢 **Low-intelligence repetitive work** (batch computation, comparison, retrieval, classification, validation, formatting, transcription) → **offloaded to local execution** at near-zero cloud-token cost
- 🔴 **High-intelligence work** (aggregation, root-cause analysis, judgment, decision-making, creative writing) → only the **condensed results** are sent back to the cloud LLM

Motto: **Grunt work goes local, wisdom stays central; data never leaves home, only conclusions fly.**

### Why it matters

Cloud LLMs bill by token, and in real-world tasks 80%+ of tokens are burned on "grunt work": pasting thousands of rows into the chat, line-by-line comparisons, repetitive formatting. Deterministic local scripts do this for free, faster, and reproducibly. This skill **institutionalizes** that workflow: Plan → Download spec → Execute locally → Upload condensed results — a four-step closed loop.

### Features

| Feature | Description |
|---------|-------------|
| Trigger phrases | Say "分拆任务" (task split) or "减少token消耗" (reduce token usage) to activate |
| Classification matrix | Built-in 🟢/🔴 decision table + iron rules for assigning subtasks |
| Four-step loop | ①Task breakdown ②Spec file offloaded locally ③Batch local execution ④Condensed upload & cloud synthesis |
| Cross-domain templates | Batch data processing / large-scale retrieval & diff / document formatting / recurring analysis / codebase & log review |
| Safety guardrails | Honesty rule (never hide anomalies), security rule (no secrets), sample-verification loop |
| Asset accumulation | Reusable scripts & specs persist on disk; repeat tasks cost zero |

### Requirements

1. An agent environment supporting SKILL.md skills (Hermes Agent recommended; adaptable to Claude Code, Kimi CLI, etc.)
2. Basic local tooling: Python 3 (pandas/numpy recommended), curl/jq, grep/ripgrep
3. Install: place `SKILL.md` into your agent's skill directory (e.g. `~/.hermes/skills/workflow/task-split/`); the agent auto-discovers it

### Open Review & Feedback

This skill is **free for anyone to use, review, and critique** 🎉

- Think the design is wrong somewhere? Disagree with the classification rules? Have real-world token-saving data?
- Open an **Issue** to share your review, suggestions, or measured results
- **Pull Requests** for new scenario templates and rules are welcome
- Praise or criticism — honest feedback is the best gift

---

## License

MIT — free to use, modify, and redistribute.
