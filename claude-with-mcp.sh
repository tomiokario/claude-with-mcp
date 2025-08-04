#!/bin/bash

# nvmを初期化（存在する場合）
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# MCPサーバーの設定を管理する関数
setup_mcp_server() {
    local server_name=$1
    local prompt_message=$2
    shift 2
    local setup_command=("$@")
    
    echo -n "$prompt_message [y/n]: "
    read -r response
    
    # 大文字小文字を区別しない比較のため小文字に変換
    response=$(echo "$response" | tr '[:upper:]' '[:lower:]')
    
    if [ "$response" = "y" ]; then
        echo "${server_name}を設定しています..."
        # コマンドを実行（evalを使用してコマンド全体を正しく展開）
        eval "${setup_command[@]}"
        
        # セットアップの成功を確認
        if [ $? -eq 0 ]; then
            echo "${server_name}の設定が完了しました。"
            return 0
        else
            echo "${server_name}の設定中にエラーが発生しました。"
            return 1
        fi
    fi
    return 0
}

# メイン処理
main() {
    # Serena MCPの設定
    setup_mcp_server \
        "Serena MCP" \
        "Serena MCPを使用しますか？" \
        claude mcp add serena -- uvx --from git+https://github.com/oraios/serena serena-mcp-server --context ide-assistant --project "$(pwd)"
    
    # エラーが発生した場合は終了
    if [ $? -ne 0 ]; then
        echo "MCPサーバーの設定に失敗しました。処理を中止します。"
        exit 1
    fi
    
    # 他のMCPサーバーをここに追加可能
    # 例:
    # setup_mcp_server \
    #     "Another MCP" \
    #     "Another MCPを使用しますか？" \
    #     'claude mcp add another -- command-for-another-mcp'
    
    # Claude Codeを起動
    echo "Claude Codeを起動しています..."
    claude
}

# スクリプトを実行
main