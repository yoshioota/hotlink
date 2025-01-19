# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks
#
#  id          :bigint           not null, primary key
#  archived    :boolean          default(FALSE), not null
#  favicon_url :text
#  title       :text             not null
#  url         :text             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_bookmarks_on_archived  (archived)
#  index_bookmarks_on_title     (title)
#  index_bookmarks_on_url       (url) UNIQUE
#
class Bookmark < ApplicationRecord
  has_one :bookmarks_bookmark_color
  has_one :bookmark_color, through: :bookmarks_bookmark_color

  scope :order_by_bookmark_color, -> {
    left_outer_joins(:bookmark_color).merge!(BookmarkColor.order_by_position)
  }

  def self.filter_by_bookmark_color_id(bookmark_color_id)
    joins(:bookmark_color).merge!(BookmarkColor.where(id: bookmark_color_id))
  end
end
