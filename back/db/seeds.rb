# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# NOTE: TODO: そのうちseed_fu化したい

color_types = [
  { name: :red, position: 2, css: 'rgb(254 226 226)' },
  { name: :blue, position: 3, css: 'rgb(219 234 254)' },
  { name: :green, position: 4, css: 'rgb(220 252 231)' },
  { name: :yellow, position: 5, css: 'rgb(254 249 195)' },
  { name: :purple, position: 6, css: 'rgb(243 232 255)' },
  { name: :orange, position: 7, css: 'rgb(255 237 213)' },
  { name: :white, position: 50, css: nil },
  { name: :gray, position: 99, css: 'rgb(209 213 219)' }
]
color_types.each do |item|
  item => name:, position:, css:
  bc = BookmarkColor.find_or_initialize_by(name:)
  bc.position = position
  bc.css = css
  bc.save!
end
