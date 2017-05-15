module WineSearcher
  class FilterValue
    attr_reader :human_name, :param_name, :bucket_key, :bucket_value, :searchkick_filter

    def initialize(human_name:, param_name: human_name.underscore, bucket_key: human_name, bucket_value: param_name, searchkick_filter: bucket_value)
      @human_name        = human_name.freeze
      @param_name        = param_name.freeze
      @bucket_key        = bucket_key.freeze
      @bucket_value      = bucket_value.freeze
      @searchkick_filter = searchkick_filter.freeze

      freeze
    end
  end
end
