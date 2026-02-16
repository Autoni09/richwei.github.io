# AI 协作固定模板（hugo-commit-flow）

本文档用于固定你和 AI 的常用指令，降低自由发挥，提升“可重复执行”。

---

## 1. 提交类（最常用）

### 模板

```text
使用 skill: hugo-commit-flow。
TYPE=<feat|fix|docs|chore|refactor|style|test|perf|build|ci|revert>
MSG="<一句话主题>"
要求：失败即停止，并返回错误原因。
```

### 示例

```text
使用 skill: hugo-commit-flow。
TYPE=docs
MSG="update homepage collaboration docs"
要求：失败即停止，并返回错误原因。
```

---

## 2. 只检查不提交

### 模板

```text
使用 skill: hugo-commit-flow，只执行检查流程，不提交。
要求输出：执行命令、检查结果、失败原因（如有）。
```

### 示例

```text
使用 skill: hugo-commit-flow，只执行检查流程，不提交。
要求输出：执行命令、检查结果、失败原因（如有）。
```

---

## 3. 提交前查看暂存范围（防止误提交）

### 模板

```text
使用 skill: hugo-commit-flow。
先仅输出当前 staged 文件列表，并确认没有 public/ 与 themes/。
确认后再继续提交。
```

### 示例

```text
使用 skill: hugo-commit-flow。
先仅输出当前 staged 文件列表，并确认没有 public/ 与 themes/。
确认后再继续提交。
```

---

## 4. 固定输出格式模板（建议每次都要求）

```text
请按以下格式输出：
1) 执行命令
2) 检查结果（PASS/FAIL）
3) 最终结果（commit hash 或失败根因）
4) 下一步建议（仅 1 条最小动作）
```

---

## 5. 推荐组合模板（直接复制可用）

```text
使用 skill: hugo-commit-flow。
TYPE=chore
MSG="refine blog workflow docs"
要求：
- 严格按固定流程执行，不跳步
- 失败即停止，并返回错误原因
- 按固定格式输出：执行命令 / 检查结果 / 最终结果 / 下一步建议
```

---

## 6. 常见错误与对应指令

- `错误：public/ 仍被跟踪`
  - 指令：`请先修复 public/ 被跟踪问题，再按 hugo-commit-flow 重试。`
- `错误：没有 staged 文件`
  - 指令：`先输出可提交文件建议，再由我确认后继续。`
- `错误：commit type 不合法`
  - 指令：`将 TYPE 改为 feat/fix/docs/chore 等合法值后重试。`

---

## 7. 说明

- 本项目 skill 位置：`.cursor/skills/hugo-commit-flow/SKILL.md`
- 固定命令入口：
  - `make check`
  - `make commit TYPE=<type> MSG="<subject>"`

---

## 8. PR 测试模板（禁止直推 main）

```text
目标：测试 PR 保护规则是否生效。
步骤：
1) 新建分支：chore/test-pr-rule
2) 做最小改动并提交
3) 推送到远程分支，不允许推送到 main
4) 创建 PR 到 main
5) 返回 PR 链接与检查结果
要求：
- 如检测到可直推 main，立即提示存在绕过风险
- 全程按固定输出格式返回
```
