module WineSearcher::Filters
  module Score
    extend WineSearcher::Filter
    extend self

    VALUES = [
      FilterValue.new(
        human_name: "100 Points",
        param_name: "100",
        bucket_key: "100",
        bucket_value: {from: 100, key: "100"},
        searchkick_filter: 100,
      ),
      FilterValue.new(
        human_name: "99 to 97 Points",
        param_name: "97-99",
        bucket_key: "97-99",
        bucket_value: {from: 97, to: 100, key: "97-99"},
        searchkick_filter: 97...100,
      ),
      FilterValue.new(
        human_name: "96 to 94 Points",
        param_name: "94-96",
        bucket_key: "94-96",
        bucket_value: {from: 94, to: 97, key: "94-96"},
        searchkick_filter: 94...97,
      ),
      FilterValue.new(
        human_name: "93 to 91 Points",
        param_name: "91-93",
        bucket_key: "91-93",
        bucket_value: {from: 91, to: 94, key: "91-93"},
        searchkick_filter: 91...94,
      ),
      FilterValue.new(
        human_name: "90 Points and Under",
        param_name: "*-90",
        bucket_key: "*-90",
        bucket_value: {to: 91, key: "*-90"},
        searchkick_filter: {lt: 91},
      ),
    ].freeze

    def values
      VALUES
    end

    def searchkick_filter_field_name
      :scores
    end

    def to_aggregate
      { field: :scores, ranges: values.map(&:bucket_value) }
    end
  end
end
