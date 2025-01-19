# frozen_string_literal: true

class Resolvers::BookmarkColor::List < Resolvers::BaseResolver
  argument :wheres, [GraphQL::Types::JSON], required: false, default_value: []
  argument :orders, [GraphQL::Types::JSON], required: false, default_value: []

  type [Types::Objects::BookmarkColor], null: false

  def resolve(
    wheres:,
    orders:
  )
    QueryBuilder::Builder.new(BookmarkColor, wheres:, orders:).call
  end
end
