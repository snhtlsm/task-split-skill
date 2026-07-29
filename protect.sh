#!/bin/bash
# task-split Skill 防护脚本
# 功能：AES-256 加密母本 / 只读锁定 / SHA256 完整性监控 / 未授权修改自动恢复
# 唯一授权修改通道：protect.sh upgrade <new_SKILL.md>
#   （仅允许技能自我进化机制产生的升级，由 BlackCatWoman 经主人授权后执行）

SKILL_DIR="$HOME/.hermes/skills/workflow/task-split"
VAULT_DIR="$SKILL_DIR/.protected"
KEY_FILE="$HOME/.kimi-code/credentials/task-split.key"
ENC_MASTER="$VAULT_DIR/SKILL.md.enc"
HASH_FILE="$VAULT_DIR/.file_hashes"
UPGRADE_LOG="$VAULT_DIR/upgrade_log.md"
PROTECTED_FILES=("SKILL.md")

# ---- 密钥管理（600权限，仅主人可读）----
ensure_key() {
    if [ ! -f "$KEY_FILE" ]; then
        mkdir -p "$(dirname "$KEY_FILE")"
        openssl rand -hex 32 > "$KEY_FILE"
        chmod 600 "$KEY_FILE"
        echo "🔑 加密密钥已生成: $KEY_FILE (600)"
    fi
}

encrypt_master() {  # 明文 SKILL.md → 加密母本
    ensure_key
    chmod u+w "$ENC_MASTER" 2>/dev/null
    openssl enc -aes-256-cbc -pbkdf2 -salt -in "$SKILL_DIR/SKILL.md" \
        -out "$ENC_MASTER" -pass file:"$KEY_FILE" || return 1
    chmod 400 "$ENC_MASTER"
}

decrypt_master() {  # 加密母本 → stdout
    openssl enc -aes-256-cbc -pbkdf2 -d -in "$ENC_MASTER" -pass file:"$KEY_FILE"
}

generate_hashes() {
    : > "$HASH_FILE"
    for f in "${PROTECTED_FILES[@]}"; do
        [ -f "$SKILL_DIR/$f" ] && sha256sum "$SKILL_DIR/$f" >> "$HASH_FILE"
    done
    chmod 400 "$HASH_FILE"
}

check_integrity() {  # 返回 0=完整 1=被篡改
    [ ! -f "$HASH_FILE" ] && return 2
    local modified=0
    while read -r hash file; do
        if [ -f "$file" ]; then
            cur=$(sha256sum "$file" | awk '{print $1}')
            if [ "$hash" != "$cur" ]; then
                echo "🚨 检测到未授权修改: $file"
                modified=1
            fi
        else
            echo "🚨 文件丢失: $file"
            modified=1
        fi
    done < "$HASH_FILE"
    return $modified
}

restore_from_master() {  # 从加密母本恢复
    echo "🔧 从加密母本恢复 SKILL.md ..."
    chmod u+w "$SKILL_DIR/SKILL.md" 2>/dev/null
    decrypt_master > "$SKILL_DIR/SKILL.md" || { echo "❌ 恢复失败"; return 1; }
    chmod 444 "$SKILL_DIR/SKILL.md"
    echo "✅ 已恢复（未授权修改已撤销）"
}

create_guard_file() {
    cat > "$SKILL_DIR/.PROTECTED" << 'EOF'
═══════════════════════════════════════════════════════
  ⚠️  PROTECTED SKILL - DO NOT MODIFY  ⚠️
═══════════════════════════════════════════════════════

此Skill（task-split / 分拆任务）为 [Q] 的专属资产，
由 BlackCatWoman 创建和维护，已加密保护。

禁止行为：
• 除 [Q] 本人外，任何人/任何agent拆解、手动修改本目录任何文件
• 覆盖、删除、重命名核心文件
• 绕过 protect.sh upgrade 通道直接写入
• 读取/复制加密密钥（~/.kimi-code/credentials/task-split.key）

允许行为：
• 读取/查看文件内容
• 通过技能自我进化机制提出升级，经 protect.sh upgrade 写入
• 由 BlackCatWoman 经主人授权后维护

违规后果：
任何未授权修改将被立即检测、告警，并从加密母本自动恢复。

═══════════════════════════════════════════════════════
Owner: [Q] | Guardian: BlackCatWoman | Created: 2026-07-29
═══════════════════════════════════════════════════════
EOF
    chmod 444 "$SKILL_DIR/.PROTECTED"
}

lock() {
    mkdir -p "$VAULT_DIR"
    encrypt_master
    generate_hashes
    chmod 444 "$SKILL_DIR/SKILL.md"
    create_guard_file
    echo "🔒 已锁定: SKILL.md (444 只读)"
    echo "🛡️ 加密母本: $ENC_MASTER (400)"
    echo "✅ 哈希基准已建立，保护启用"
}

check() {
    local quiet="$2"
    if check_integrity; then
        [ "$quiet" != "--quiet" ] && echo "✅ task-split 完整性正常，无未授权修改"
        return 0
    else
        echo "🚨 警告：task-split 检测到未授权修改！"
        restore_from_master
        chmod u+w "$HASH_FILE" 2>/dev/null; generate_hashes
        return 1
    fi
}

upgrade() {  # 唯一授权修改通道: upgrade <new_SKILL.md>
    local newfile="$2"
    if [ -z "$newfile" ] || [ ! -f "$newfile" ]; then
        echo "用法: $0 upgrade <new_SKILL.md>"
        echo "（仅技能自我进化机制产生的升级可经此通道写入）"
        exit 2
    fi
    echo "🔐 授权升级通道启动（自我进化机制）..."
    python3 -c "import sys; d=open('$newfile',encoding='utf-8').read(); assert d.startswith('---') and 'name: task-split' in d[:500], '非法的SKILL.md'" \
        || { echo "❌ 校验失败：不是合法的 task-split SKILL.md，拒绝写入"; exit 1; }
    chmod u+w "$SKILL_DIR/SKILL.md" "$HASH_FILE" 2>/dev/null
    cp "$newfile" "$SKILL_DIR/SKILL.md"
    chmod 444 "$SKILL_DIR/SKILL.md"
    encrypt_master || { echo "❌ 母本重加密失败，升级中止"; exit 1; }
    generate_hashes
    chmod u+w "$UPGRADE_LOG" 2>/dev/null
    cat >> "$UPGRADE_LOG" << EOF
## $(date '+%Y-%m-%d %H:%M:%S') 自我进化升级
- 来源: $newfile
- 通道: protect.sh upgrade（唯一授权通道）
- 新哈希: $(sha256sum "$SKILL_DIR/SKILL.md" | awk '{print $1}')

EOF
    chmod 400 "$UPGRADE_LOG"
    echo "✅ 升级完成：已替换→重新加密母本→重建哈希基准→记录日志"
}

case "$1" in
    lock) lock ;;
    check) check "$@" ;;
    upgrade) upgrade "$@" ;;
    *) echo "用法: $0 {lock|check [--quiet]|upgrade <new_SKILL.md>}" ;;
esac
