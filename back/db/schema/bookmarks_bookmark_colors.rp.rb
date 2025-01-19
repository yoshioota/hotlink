# frozen_string_literal: true

table_name = :bookmarks_bookmark_colors

create_table(table_name, $table_options) do |t|
  t.bigint :bookmark_id, null: false, index: true
  t.bigint :bookmark_color_id, null: false, index: true

  t.timestamps
end

add_index table_name, %i[bookmark_id bookmark_color_id], unique: true

add_foreign_key table_name, :bookmarks, on_delete: :cascade
add_foreign_key table_name, :bookmark_colors, on_delete: :cascade
