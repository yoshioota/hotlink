# frozen_string_literal: true

class Mutations::Bookmark::Save < Mutations::BaseMutation
  graphql_name name.split('::')[1..].join

  argument :url, GraphQL::Types::String, required: true
  argument :title, GraphQL::Types::String, required: false
  argument :favicon_url, GraphQL::Types::String, required: false

  type Types::Objects::Bookmark, null: false

  def resolve(
    url:,
    title:,
    favicon_url:
  )
    bookmark =
      ApplicationRecord.transaction do
        bookmark = Bookmark.lock.find_or_initialize_by(url:)

        bookmark.update!(
          title:,
          favicon_url:,
          archived: false,
          bookmark_color: BookmarkColor.default
        )

        bookmark
      end

    BookmarkChannel::Broadcaster.saved

    bookmark.reload
  end
end
