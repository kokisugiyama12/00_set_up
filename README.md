# MacBook Windows-like Setup

Windowsに慣れている人向けに、macOSのキー操作・ウィンドウ操作をWindowsに近づける設定集。

## 必要なアプリ

| アプリ | 用途 | インストール |
|--------|------|-------------|
| [Karabiner-Elements](https://karabiner-elements.pqrs.org/) | キーリマップ・ショートカット変換 | `setup.sh` で自動 |
| [Rectangle](https://rectangleapp.com/) | ウィンドウのディスプレイ間移動 | `setup.sh` で自動 |

## 設定一覧

### 設定1: Caps Lock → Command（Karabiner）

左下の Caps Lock キー（上矢印に点のマーク）を Command として使えるようにする。
元の Command キーもそのまま残るので、Command が2つになる。

| 操作 | 動作 |
|------|------|
| CapsLock + C | コピー |
| CapsLock + V | ペースト |
| CapsLock + X | 切り取り |
| CapsLock + Z | 元に戻す |
| CapsLock + A | 全選択 |
| CapsLock + S | 保存 |
| CapsLock + Tab | アプリ切替（Cmd+Tab） |

### 設定2: Control 単押しで日本語/英語切替（Karabiner）

Control キーのデュアルロール化。

| 操作 | 動作 |
|------|------|
| Control 単押し | 英語⇄日本語をトグル |
| Control + 他キー | 通常の Control として動作 |

### 設定3: F11/F12 → Home/End（Karabiner）

| 操作 | 動作 |
|------|------|
| F11 | 行頭（Home） |
| F12 | 行末（End） |
| Shift + F11 | 行頭まで選択 |
| Shift + F12 | 行末まで選択 |

### 設定4: スクリーンショット（Karabiner）

| 操作 | 動作 |
|------|------|
| Shift + Cmd + S | 範囲選択してクリップボードにコピー（Win+Shift+S 相当） |

### 設定5: デスクトップ表示（Karabiner）

| 操作 | 動作 |
|------|------|
| Cmd + D | デスクトップを表示（Win+D 相当） |

### 設定6: ウィンドウのディスプレイ間移動（Rectangle）

| 操作 | 動作 |
|------|------|
| Shift + Cmd + → | 次のディスプレイへ移動 |
| Shift + Cmd + ← | 前のディスプレイへ移動 |

### 設定7: F1〜F12を標準ファンクションキーとして使用（macOS + Karabiner）

Fn キーを押さなくても F10 などが標準のファンクションキーとして動作する。
F10 で変換中の文字を半角に変換できる（Windows標準と同じ）。

Karabiner 側で `fn_function_keys` マッピングを設定し、メディアキー（音量・輝度等）を
F1〜F12 に変換している。macOS 側も `com.apple.keyboard.fnState = true` に設定。

### 設定8: 日本語入力（macOS標準）

| 設定項目 | 値 |
|----------|-----|
| ライブ変換 | OFF（自動変換しない） |
| Windows風キーバインド | ON（Enter 1回で変換確定） |

設定場所: システム設定 → キーボード → 入力ソース → 編集 → 日本語 - ローマ字入力

## セットアップ手順

### 自動セットアップ

```bash
git clone https://github.com/kokisugiyama12/00_set_up.git
cd 00_set_up
chmod +x setup.sh
./setup.sh
```

### 手動で必要な設定

`setup.sh` 実行後、以下は手動で設定する必要がある。

#### 1. 権限の付与

システム設定 → プライバシーとセキュリティ:

- **アクセシビリティ**: Karabiner-Elements, Rectangle を ON
- **入力監視**: Karabiner-Elements, karabiner_grabber を ON
- **一般 → ログイン項目と機能拡張 → ドライバ機能拡張**: `Karabiner-DriverKit-VirtualHIDDevice` を ON

#### 2. 日本語入力の設定

システム設定 → キーボード → 入力ソース → 編集 → 日本語 - ローマ字入力:

- ライブ変換: **OFF**
- Windows風のキー操作: **ON**

#### 3. 再起動

全ての設定を確実に反映するため、Mac を再起動する。

## ファイル構成

```
00_set_up/
├── README.md                  # この文書
├── setup.sh                   # 自動セットアップスクリプト
└── karabiner/
    ├── karabiner.json         # Karabiner 本体設定（プロファイル・ルール有効化済み）
    └── windows_like_jis.json  # Complex Modifications ルール定義
```

## 動作確認環境

- MacBook Pro（JIS内蔵キーボード）
- macOS Sequoia 15.4
- Karabiner-Elements 15.9.0
- Rectangle 0.95
