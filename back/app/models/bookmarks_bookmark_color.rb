# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmarks_bookmark_colors
#
#  id                :bigint           not null, primary key
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  bookmark_color_id :bigint           not null
#  bookmark_id       :bigint           not null
#
# Indexes
#
#  idx_on_bookmark_id_bookmark_color_id_aa54d9ca57       (bookmark_id,bookmark_color_id) UNIQUE
#  index_bookmarks_bookmark_colors_on_bookmark_color_id  (bookmark_color_id)
#  index_bookmarks_bookmark_colors_on_bookmark_id        (bookmark_id)
#
# Foreign Keys
#
#  fk_rails_...  (bookmark_color_id => bookmark_colors.id) ON DELETE => cascade
#  fk_rails_...  (bookmark_id => bookmarks.id) ON DELETE => cascade
#

class BookmarksBookmarkColor < ApplicationRecord
  belongs_to :bookmark
  belongs_to :bookmark_color
end
