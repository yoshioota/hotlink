# frozen_string_literal: true

class Types::QueryType < Types::BaseObject
  # NOTE: ↓よくわからんけどこれいる？

  field :node, Types::NodeType, null: true, description: 'Fetches an object given its ID.' do
    argument :id, ID, required: true, description: 'ID of the object.'
  end

  def node(id:)
    context.schema.object_from_id(id, context)
  end

  field :nodes, [Types::NodeType, { null: true }], null: true,
                                                   description: 'Fetches a list of objects given a list of IDs.' do
    argument :ids, [ID], required: true, description: 'IDs of the objects.'
  end

  def nodes(ids:)
    ids.map { |id| context.schema.object_from_id(id, context) }
  end

  # Add root-level fields here.
  # They will be entry points for queries on your schema.

  field :bookmarks, resolver: Resolvers::Bookmark::List
  field :bookmark, resolver: Resolvers::Bookmark::Show
  field :bookmark_colors, resolver: Resolvers::BookmarkColor::List
end
