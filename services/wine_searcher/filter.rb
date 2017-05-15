module WineSearcher
  module Filter
    MissingAggregationDataError = Class.new(StandardError)

    def values
      raise NotImplementedError
    end

    def filter_name
      to_s.split('::').last.underscore
    end

    def searchkick_filter_field_name
      filter_name.to_sym
    end

    def to_aggregate
      {}
    end

    def options_for_select(search_object = nil)
      if search_object
        options_for_select_with_result_count(search_object)
      else
        options_for_select_without_result_count
      end
    end

    def param_to_human(param)
      values.find { |value|
        value.to_param == param
      }&.to_s
    end

    private

    def options_for_select_without_result_count
      values.map { |value|
        [value.to_s, value.to_param]
      }
    end

    def options_for_select_with_result_count(search_object)
      options       = options_for_select_without_result_count
      result_counts = result_counts_for(search_object, filter_name)

      options.map.with_index { |option, index|
        option << { "data-result-count" => result_counts[values[index].bucket_key] }
      }
    end

    def result_counts_for(search_object, filter_name)
      results = extract_aggregate(search_object, filter_name).map { |bucket|
        [
          bucket["key"],
          bucket["doc_count"]
        ]
      }

      Hash[results].tap { |hash| hash.default = 0 }
    end

    def extract_aggregate(search_object, filter_name)
      raise MissingAggregationDataError unless search_object.aggs

      search_object.aggs.dig(filter_name, "buckets").tap do |aggs|
        raise MissingAggregationDataError,
          "Aggregations present, but not for #{filter_name} field" unless aggs
      end
    end
  end
end
