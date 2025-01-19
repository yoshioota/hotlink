# frozen_string_literal: true

table_name = :bookmark_colors

create_table(table_name, $table_options) do |t|
  t.integer :position, default: 1
  t.string :name, null: false, index: { unique: true }
  t.string :css
  t.timestamps
end
