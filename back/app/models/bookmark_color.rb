# frozen_string_literal: true

# == Schema Information
#
# Table name: bookmark_colors
#
#  id         :bigint           not null, primary key
#  css        :string
#  name       :string           not null
#  position   :integer          default(1)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_bookmark_colors_on_name  (name) UNIQUE
#
class BookmarkColor < ApplicationRecord
  DEFAULT_COLOR = 'white'

  has_many :bookmarks_bookmark_colors

  scope :order_by_position, -> { order(:position) }

  def self.default
    @default ||= BookmarkColor.find_by!(name: DEFAULT_COLOR)
  end
end
