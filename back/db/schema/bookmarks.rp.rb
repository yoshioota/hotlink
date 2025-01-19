# frozen_string_literal: true

table_name = :bookmarks

create_table(table_name, $table_options) do |t|
  t.text :url, null: false, index: { unique: true }
  t.text :title, null: false, index: true
  t.text :favicon_url

  # booleanなnull:falseにしてdefaultをつけないとtrue or falseの2値にならない
  t.boolean :archived, null: false, default: false, index: true

  t.timestamps
end
