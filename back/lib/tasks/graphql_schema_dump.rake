# frozen_string_literal: true

=begin
Note: GraphQLのスキーマをダンプするためのRakeタスク
=end

require 'graphql/rake_task'

load_context = proc do
  current_user = nil # User.first

  {
    current_user:
  }
end

GraphQL::RakeTask.new(
  schema_name: 'HotlinkSchema',
  load_context:,
  directory: 'graphql_schema'
)
