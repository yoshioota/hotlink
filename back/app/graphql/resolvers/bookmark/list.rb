# frozen_string_literal: true

class Resolvers::Bookmark::List < Resolvers::BaseResolver
  argument :wheres, [GraphQL::Types::JSON], required: false, default_value: []
  argument :orders, [GraphQL::Types::JSON], required: false, default_value: []

  type [Types::Objects::Bookmark], null: false

  def resolve(
    wheres:,
    orders:
  )
    QueryBuilder::Builder.new(Bookmark, wheres:, orders:).call
  end
end
