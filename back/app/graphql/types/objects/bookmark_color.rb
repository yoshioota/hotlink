# frozen_string_literal: true

class Types::Objects::BookmarkColor < Types::BaseObject
  graphql_name BookmarkColor.name

  field :id, ID, null: false

  field :position, GraphQL::Types::Int
  field :name, GraphQL::Types::String, null: false
  field :title, GraphQL::Types::String
  field :css, GraphQL::Types::String

  field :created_at, GraphQL::Types::ISO8601DateTime, null: false
  field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
end
