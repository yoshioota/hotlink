# frozen_string_literal: true

# NOTE: 汎用的に検索するクラス。本番ではつかう場合はよくよく注意すること

class QueryBuilder::Builder
  OP_MAP = {
    eq: '= ?',
    not_eq: '!= ?',
    like: 'LIKE ?',
    lt: '< ?',
    lteq: '<= ?',
    gt: '> ?',
    gteq: '>= ?',
    in: 'in (?)',
    not_in: 'not in (?)'
  }.freeze

  DIRECTION_MAP = {
    asc: 'ASC',
    desc: 'DESC'
  }.freeze

  def initialize(table, wheres: [], orders: [])
    @table = table
    @wheres = wheres.map(&:deep_symbolize_keys)
    @orders = orders
    @column_names = table.column_names
  end

  def call
    records = @table.all

    records = build_where(records)
    records = build_order(records)
    records
  end

  def build_where(records)
    @wheres.each do |where_part|
      if /^filter_by_/.match?(field_name = where_part[:field_name])
        records = records.public_send(field_name, where_part[:value])
      else
        sql_fragment = build_where_fragment(where_part)

        records.where!(sql_fragment, where_part.fetch(:value))
      end
    end

    records
  end

  def build_order(records)
    @orders.each do |order_part|
      case order_part
      when Array
        if order_part.size == 1 && /^order_by_/.match?(order_part.first)
          records = records.send(order_part.first.to_sym)
        else
          records.order!(build_order_fragment_array(order_part))
        end
      when Hash
        records.order!(build_order_fragment(order_part.deep_symbolize_keys))
      else
        raise "Unsupported order type: #{order_part.inspect}"
      end
    end

    records
  end

  def build_where_fragment(where)
    field_name = where.fetch(:field_name)

    raise [@column_names, field_name].inspect unless field_name.in?(@column_names)

    op = OP_MAP.fetch(where.fetch(:op).to_sym)

    "#{field_name} #{op}"
  end

  def build_order_fragment_array(order_part)
    field_name = order_part.first

    raise [@column_names, field_name].inspect unless field_name.in?(@column_names)

    direction = DIRECTION_MAP.fetch(order_part.second.downcase.to_sym)

    "#{field_name} #{direction}"
  end

  def build_order_fragment(order)
    field_name = order.fetch(:field_name)

    raise [@column_names, field_name].inspect unless field_name.in?(@column_names)

    direction = DIRECTION_MAP.fetch(order.fetch(:direction).downcase.to_sym)

    "#{field_name} #{direction}"
  end
end
