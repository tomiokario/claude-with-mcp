# Claude with MCP - MCPサーバー設定付きClaude起動スクリプト

## 概要
このスクリプトは、Claude Codeを起動する前にMCPサーバーの設定を対話的に行うシェルスクリプトです。現在はSerena MCPに対応しており、簡単に他のMCPサーバーを追加できる拡張可能な設計になっています。

## 使い方

### 基本的な使用方法
```bash
./claude-with-mcp.sh
```

スクリプトを実行すると、以下のような対話的なプロンプトが表示されます：
```
Serena MCPを使用しますか？[y/n]: 
```

- `y` を入力: Serena MCPを設定してからClaude Codeを起動
- `n` を入力: MCPの設定をスキップしてClaude Codeを起動

## 機能

### 現在対応しているMCPサーバー
- **Serena MCP**: IDEアシスタントコンテキストでプロジェクトを支援

### 拡張性
新しいMCPサーバーを追加する場合は、`main()`関数内に以下のように追加します：

```bash
setup_mcp_server \
    "MCPサーバー名" \
    "プロンプトメッセージ" \
    'セットアップコマンド'
```

例：
```bash
setup_mcp_server \
    "GitHub MCP" \
    "GitHub MCPを使用しますか？" \
    'claude mcp add github -- npx @modelcontextprotocol/server-github'
```

## 必要な環境

- Bash
- Claude CLI (`claude`コマンド)
- インターネット接続（MCPサーバーのインストール時）

## インストール

1. スクリプトをダウンロードまたはコピー
2. 実行権限を付与（すでに付与済みの場合はスキップ）：
```bash
chmod +x claude-with-mcp.sh
```

## エラーハンドリング

- MCPサーバーの設定に失敗した場合、エラーメッセージを表示して処理を中止します
- 各MCPサーバーの設定は独立しており、一つが失敗しても他の設定には影響しません
