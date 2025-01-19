# frozen_string_literal: true

class Types::MutationType < Types::BaseObject
  field :bookmark_archive, mutation: Mutations::Bookmark::Archive
  field :bookmark_create, mutation: Mutations::Bookmark::Create
  field :bookmark_delete, mutation: Mutations::Bookmark::Delete
  field :bookmark_save, mutation: Mutations::Bookmark::Save
  field :bookmark_update, mutation: Mutations::Bookmark::Update
end
