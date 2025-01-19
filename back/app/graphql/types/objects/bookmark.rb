# frozen_string_literal: true

# NOTE: _typeと書かないで定義するにはこんな感じで書く。
# ちなみに_typeと書きたくないのはAbcTypeモデルがあった場合AbcTypeTypeと書かないといけなかったり
# で微妙なため

class Types::Objects::Bookmark < Types::BaseObject
  graphql_name Bookmark.name

  field :id, ID, null: false

  field :url, GraphQL::Types::String, null: false
  field :title, GraphQL::Types::String, null: false
  field :favicon_url, GraphQL::Types::String, null: true
  field :archived, GraphQL::Types::Boolean, null: false

  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false

  field :bookmarks_bookmark_color, Types::Objects::BookmarksBookmarkColor, null: true

  # NOTE: gem 'batch-loader' の機能でこんな感じでN+1を回避する
  # あと、has_many throughは一発で取ってこれないっぽいのでhas_manyを1段ずつクエリしていかないといけないみたい。
  def bookmarks_bookmark_color
    BatchLoader::GraphQL.for(object.id).batch do |ids, loader|
      BookmarksBookmarkColor.where(bookmark_id: ids).each { loader.call(_1.bookmark_id, _1) }
    end
  end
end
