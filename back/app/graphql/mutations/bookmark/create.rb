# frozen_string_literal: true

class Mutations::Bookmark::Create < Mutations::BaseMutation
  graphql_name name.split('::')[1..].join

  argument :url, GraphQL::Types::String, required: true
  argument :title, GraphQL::Types::String, required: true

  type Types::Objects::Bookmark, null: false

  def resolve(
    url:,
    title:
  )
    if Bookmark.exists?(url:)
      raise GraphQL::ExecutionError, 'すでにある'
    end

    # NOTE: いわゆるビジネスロジックはmodelに移動したり、serviceつくったりusecaseつくったり、まあ好きなとこにおいてください。
    # 自分は個人でやる分にはresolverとmutationで単一責任原則っぽく使えるのでここに置いてます。

    ApplicationRecord.transaction do
      bookmark = Bookmark.create!(
        url:,
        title:
      )
      bookmark.create_bookmarks_bookmark_color!(bookmark_color: BookmarkColor.default)

      bookmark
    end
  end
end
