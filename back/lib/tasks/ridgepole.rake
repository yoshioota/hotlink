# frozen_string_literal: true

namespace :ridgepole do
  desc 'export'
  task :export do
    cmd = "bundle exec ridgepole -c config/database.yml -E #{Rails.env} --split --export -o db/schema/Schemafile"
    puts cmd
    system cmd
  end

  desc 'dry-run'
  task :'dry-run' do
    cmd = "bundle exec ridgepole -c config/database.yml -E #{Rails.env} -f db/Schemafile --apply --dry-run"
    puts cmd
    system cmd
  end

  desc 'apply'
  task :apply do
    cmd = "bundle exec ridgepole -c config/database.yml -E #{Rails.env} -f db/Schemafile --apply --drop-table"
    puts cmd
    system cmd
  end

  desc 'update'
  task update: %i[ridgepole:apply db:schema:dump] do
    cmd = 'bundle exec annotaterb models'
    puts cmd
    system cmd
  end
end
