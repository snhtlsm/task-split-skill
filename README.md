# 分拆任务 · Task Split — Cloud/Local Intelligence Layering Skill

> **v3.6.0 · 更新于 2026-10-05** · 💰 Paid Skill（付费下载，本仓为落地页）

[中文](#中文说明) | [English](#english)

---

## 中文说明

### 这是什么

**分拆任务（task-split）** 是一个 AI Agent 技能（Hermes Agent / 兼容 SKILL.md 规范的各类 Agent CLI），把**高复杂度、高 token 消耗**的任务拆成两层执行：

- 🟢 **低智能重复工作**（重复计算、比对、检索、分类、校验、排版、誊抄）→ **下沉本地执行**，几乎零云端 token
- 🔴 **高智能工作**（汇总、归因、判断、决策、创作）→ 只把**浓缩成果**回传云端大模型

一句话口诀：**苦力下基层，智慧留中枢；数据不出门，结论坐飞机。**

云端大模型按 token 计费，实际任务中 80%+ 的 token 浪费在"苦力活"上。本技能把这种工作方式**制度化**：⓪适配评估 → ①拆分 → ②下沉 → ③本地执行 → ④浓缩回传，五步闭环。

### 功能特性（v3.6.0）

| 功能 | 说明 |
|------|------|
| 智能分级矩阵 | 🟢/🔴 决策表 + 分级铁律，逐项判定子任务归属 |
| 五步闭环 | ⓪适配评估 ①拆分清单 ②规范下沉 ③本地批量执行 ④浓缩回传汇总 |
| 自我进化机制 | 机制不适配任务时先进化规则再执行；进化效果记账，无效回滚 |
| 功能① 任务卡+本地学习 | 云端定规范、本地照卡执行、复盘沉淀，本地越用越聪明 |
| 功能② 资料缓存复用 | 搜索资料/引用本地缓存，相似任务零云端消耗（密钥绝不进缓存） |
| 功能③ 能力本地化蒸馏 | 云端高阶方法蒸馏为本地可运行 skill，验收测试+入库保护 |
| 功能④ 方案演进擂台 | 1 ACTIVE + 1 CLOUD + ≤5 BACKUPS，每3次调用自动比对，优者晋升 |
| 回传压缩决策树 | L1-L5 五层压缩：回传 >2000 tokens 必压缩，按内容类型自动选路 |
| 会话/子代理隔离 | 长任务子代理执行，主上下文零污染 |
| 红线机制 | 诚实红线（禁止隐瞒异常）、安全红线（不碰 secrets）、抽样校验闭环 |

### 💰 价格与获取（Paid Access）

- **一次性买断：¥49.9 / US$9.9**（含后续全部更新）
- 支付方式：
  - **GitHub Sponsors**：https://github.com/sponsors/snhtlsm （一次性赞助 ≥$9.9 即获得访问权）
  - **微信 / 支付宝**：收款码见下方图片
- **流程**：付款 → 备注你的 GitHub 用户名 → 作者邀请你加入私有仓库 `task-split-skill-pro` → 按仓内 README 安装

![微信支付](pay-wechat.jpg) ![支付宝](pay-alipay.png)

### 使用要求

1. 支持 SKILL.md 技能的 Agent 环境（Hermes Agent 最佳；Claude Code / Kimi CLI 等亦可）
2. 本地基础工具：Python 3（建议 pandas/numpy）、curl/jq、grep/ripgrep

### License

- 本公开仓内容：**View & Review Only**，禁止转载仓内历史内容
- 付费用户：个人使用授权。**禁止**二次分发、转售、公开 skill 内容、逆向保护机制
- Copyright © 2026 snhtlsm. All rights reserved.

---

## English

**Task Split** is an AI-agent skill (Hermes Agent / any SKILL.md-compatible agent CLI) that splits high-token tasks into two layers:

- 🟢 **Low-intelligence grunt work** (batch compute, diff, retrieval, classify, validate, format) → offloaded to **local execution** at near-zero token cost
- 🔴 **High-intelligence work** (synthesis, root-cause, judgment, decisions) → only **condensed results** go back to the cloud LLM

Motto: **Grunt work goes local, wisdom stays central; data never leaves home, only conclusions fly.**

### Highlights (v3.6.0, 2026-10-05)

- 🟢/🔴 classification matrix + five-step closed loop (Adapt → Plan → Offload → Execute → Upload)
- Self-evolution: rules/templates evolve before misfit tasks run; scored and rolled back if ineffective
- Task cards & local learning · search-result caching · capability distillation to local skills · scheme-evolution arena (1 ACTIVE + 1 CLOUD + ≤5 BACKUPS)
- L1–L5 upload compression tree (>2000 tokens must compress) · subagent isolation · honesty & security guardrails

### 💰 Paid Access

- **One-time: US$9.9 / ¥49.9** (all future updates included)
- Payment: **GitHub Sponsors** https://github.com/sponsors/snhtlsm (≥$9.9 one-time) · WeChat / Alipay (QR codes above)
- Flow: pay → note your GitHub username → you get invited to the private repo `task-split-skill-pro` → install per its README

### License

Public repo: **View & Review Only**. Buyers: personal-use license; redistribution, resale, and reverse-engineering are prohibited. Copyright © 2026 snhtlsm. All rights reserved.

---

*Author: snhtlsm | Built by BlackCatWoman*
