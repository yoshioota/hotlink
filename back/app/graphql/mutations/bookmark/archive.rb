# frozen_string_literal: true

class Mutations::Bookmark::Archive < Mutations::BaseMutation
  # NOTE: ちょっと変わったディレクトリ構造してるので設定。
  # mutations, resolversの直下にモデル名にてネストする理由は
  # ここに丸っとおくとめちゃくちゃファイルが多くなるからです
  # あとちょっと変わるけどgraphql_nameを設定しないと graphqlのschemaの mutationのInputとかがおかしくなる。
  # 特にAbcTypeみたいなクラス名はすんごくおかしくなる。。

  graphql_name name.split('::')[1..].join

  argument :id, GraphQL::Types::ID, required: true

  type GraphQL::Types::Boolean, null: false

  def resolve(
    id:
  )
    Bookmark.find(id).update!(archived: true)

    true
  end
end
