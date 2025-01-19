# README

## はじめに

Rails 8とNext.js 15とその通信はGraphQLで行うWebアプリのサンプルを作ったので公開します。
サンプルなんで所々粗いですが、概要を掴むくらいには使えるかと思うので参考になればと思います。

### ポイント

- 他のディレクトリからコピってきたのでcommit logが無いですがご了承ください
- ポイントとなる箇所はNOTE: とコメントしてあるのでgrepして調べてください

## これ何？

作業をする上で特に重要なリンクを登録し管理するWebアプリです
例えば仕事でタスクをやるとnotion, figma, githubではbackendのPRリンク, frontendのPRリンク,
backendとfrontendのベースブランチ、 小タスクのPRのリンク, google spreadsheetのリンク、、、
とかとか大量に必要なリンクが出てくるのでこれに登録してすぐに開けるようにしたりしてます。

ちなみにChromeの拡張機能もあり、Chromeから一発でこのWebアプリに登録することも可能です。

## ディレクトリ構成

- back -> Rails
- front -> Next.js
- post_link -> Chrome機能拡張
- dockers -> 今回の開発に使ったdockerたち

## 使ってる技術

### Backend

- Ruby On Rails 8
  - ActionCable
- ridgepole
- graphql-ruby
  - batch-loader

### Frontend
- Next.js 15
- Apollo Client
- Tailwind CSS
  - shadcn/ui
- react-hook-form
- zod
- date-fns

### Chrome機能拡張
- webpack

## その他

### Backend
- RSpec, factory_bot は未実装。そのうちやるかも
- 今回権限系がなかったのでgraphqlのfieldの非表示とかはやってません。そのうち機会があったらやるかも
- CIは,そのうちやるかも
- デプロイはそのうちやるかも(Fly.ioとか)
- Style/ClassAndModuleChildren は compactにしてあります。nestedはソースが空中戦になるのであんまし好きじゃないので
  - ※ 昔は本番でモジュール未定義エラーとか出てたりしてたけど最近はいけるような気がする(ダメなら考えます)。 
- gem solid系は定義してるけど使用せずredisつかってます。fly.ioとかの親和性があるのでそのうちやりたい

### Frontend
- App Routerを使用してます
- TypeScriptの型はちょこちょこanyが入ってます。そのうちちゃんとやるかも
- jest, storybook は未実装。そのうちやるかも
- graphqlのschema.graphql等から型を生成するのは未実装。そのうちやるかも
- CIは,そのうちやるかも
- デプロイはそのうちやるかも(Vercelとか)

## 動かし方

```bash
1. 適当なディレクトリに行く ~/projects とか
2. git clone git@github.com:yoshioota/hotlink.git
```

### Backend

#### envコピー

```bash
cd ~/projects/hotlink
cp dot.env.example .env
cp back/dot.env.example back/.env
cp front/dot.env.local.example front/.env.local
```

#### docker compose up

```bash
cd ~/projects/hotlink
docker compose up
```

#### DB構築

※ ちなみにridgepole使ってます

```bash
cd ~/projects/hotlink/back
rails db:create
rails ridgepole:update
rails db:seed
```

#### マイグレーション

```
cd ~/projects/hotlink/back
rails ridgepole:update
```

### Frontend

frontはdocker compose立ち上げれば普通に動きます

デフォルトURLは以下

- http://localhost:4005/

### Chrome機能拡張

※ あらかじめchrome://extensionsにてDeveloper modeをONにしておく必要あり

1. Chromeを立ち上げる
2. アドレスバーから chrome://extensions/ を入力して機能拡張メニューに遷移し [Load unpacked] ボタンからdistを選択する

そうするとChrome機能拡張として使えるはず

## ライセンス

MIT
