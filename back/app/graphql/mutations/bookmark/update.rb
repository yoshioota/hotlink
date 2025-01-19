# frozen_string_literal: true

class Mutations::Bookmark::Update < Mutations::BaseMutation
  graphql_name name.split('::')[1..].join

  argument :id, GraphQL::Types::BigInt, required: true
  argument :url, GraphQL::Types::String, required: true
  argument :title, GraphQL::Types::String, required: true
  argument :bookmark_color_id, GraphQL::Types::Int, required: false, default_value: nil

  type Types::Objects::Bookmark, null: false

  def resolve(
    id:,
    url:,
    title:,
    bookmark_color_id:
  )
    record = Bookmark.find(id)

    ApplicationRecord.transaction do
      record.update!(
        url:,
        title:
      )

      record.bookmark_color =
        bookmark_color_id.present? ?
          BookmarkColor.find(bookmark_color_id) :
          BookmarkColor.default
    end

    record
  end
end
