# frozen_string_literal: true

class Mutations::Bookmark::Delete < Mutations::BaseMutation
  graphql_name name.split('::')[1..].join

  argument :id, GraphQL::Types::ID, required: true

  type GraphQL::Types::Boolean, null: false

  def resolve(
    id:
  )
    Bookmark.find(id).destroy!

    BookmarkChannel::Broadcaster.saved

    true
  end
end
