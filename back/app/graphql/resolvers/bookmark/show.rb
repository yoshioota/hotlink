# frozen_string_literal: true

class Resolvers::Bookmark::Show < Resolvers::BaseResolver
  argument :id, GraphQL::Types::ID, required: true

  type Types::Objects::Bookmark, null: false

  def resolve(
    id:
  )
    Bookmark.find(id)
  end
end
