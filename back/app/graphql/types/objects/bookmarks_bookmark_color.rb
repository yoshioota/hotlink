# frozen_string_literal: true

class Types::Objects::BookmarksBookmarkColor < Types::BaseObject
  graphql_name BookmarksBookmarkColor.name

  field :id, ID, null: false

  field :bookmark_id, GraphQL::Types::ID, null: false
  field :bookmark_color_id, GraphQL::Types::ID, null: false

  field :bookmark, Types::Objects::Bookmark, null: false
  field :bookmark_color, Types::Objects::BookmarkColor, null: false

  def bookmark_color
    BatchLoader::GraphQL.for(object.bookmark_color_id).batch do |ids, loader|
      BookmarkColor.where(id: ids).each { loader.call(_1.id, _1) }
    end
  end

  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end
