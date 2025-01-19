# README

## インストール

### envコピー

```bash
cp .env.example .env
cp back/.env.example back/.env
cp front/.env.local.example front/.env.local
```

### docker compose up

```bash
docker compose up
```

## DB構築

※ ちなみにridgepole使ってます

```bash
cd back
rails db:create
rake ridgepole:update
rails db:seed
```

## マイグレーション

```
rake ridgepole:update
```
