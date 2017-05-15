module WineSearcher
  extend self

  Error = Class.new(StandardError)
  UnknownFilterError = Class.new(Error)

  FILTERS = [
    Filters::BottleSize,
    Filters::Country,
    Filters::Price,
    Filters::Region,
    Filters::Score,
    Filters::Varietal,
    Filters::Vintage,
  ].freeze

  def run(query = "*", aggs: true, searchkick_options: {}, **filters)
    search_options = {
      where: {
        any_bottles_in_stock: true,
      }.merge(process_filters(filters)),
    }

    if aggs
      search_options[:aggs] = aggregates
    end

    Wine.search(query, search_options.deep_merge(searchkick_options))
  end

  def param_to_human(filter_name, param)
    find_filter(filter_name).param_to_human(param)
  end

  def filter_options(filter_name, search_object = nil)
    find_filter(filter_name).options_for_select(search_object)
  end

  private

  def find_filter(filter_name)
    FILTERS.find { |f| f.filter_name == filter_name.to_s }.tap do |filter|
      raise UnknownFilterError, filter_name unless filter
    end
  end

  def process_filters(search_filters)
    search_filters.each_with_object({}) { |(param_name, param_value), where|
      filter = find_filter_by_name(param_name)
      raise UnknownFilterError, param_name unless filter

      value = find_filter_value_by_param(filter, param_value)
      next unless value

      where[filter.searchkick_filter_field_name] = value.searchkick_filter
    }
  end

  def aggregates
    FILTERS.each_with_object({}) { |filter, aggs|
      aggs[filter.filter_name] = filter.to_aggregate
    }
  end

  def find_filter_by_name(name)
    name = name.to_s

    FILTERS.find do |filter|
      filter.filter_name == name
    end
  end

  def find_filter_value_by_param(filter, param_value)
    filter.values.find do |value|
      value.param_name == param_value
    end
  end
end
