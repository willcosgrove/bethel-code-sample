module WineSearcher::Filters
  module Price
    extend WineSearcher::Filter
    extend self

    VALUES = [
      FilterValue.new(
        human_name: "$30 and Under",
        param_name: "*-31",
        bucket_key: "*-31",
        bucket_value: {to: 3100, key: "*-31"},
        searchkick_filter: {lt: 3100},
      ),
      FilterValue.new(
        human_name: "$31 to $50",
        param_name: "31-51",
        bucket_key: "31-51",
        bucket_value: {from: 3100, to: 5100, key: "31-51"},
        searchkick_filter: 3100...5100,
      ),
      FilterValue.new(
        human_name: "$51 to $100",
        param_name: "51-101",
        bucket_key: "51-101",
        bucket_value: {from: 5100, to: 10100, key: "51-101"},
        searchkick_filter: 5100...10100,
      ),
      FilterValue.new(
        human_name: "$101 to $250",
        param_name: "101-251",
        bucket_key: "101-251",
        bucket_value: {from: 10100, to: 25100, key: "101-251"},
        searchkick_filter: 10100...25100,
      ),
      FilterValue.new(
        human_name: "$251 and Over",
        param_name: "251-*",
        bucket_key: "251-*",
        bucket_value: {from: 25100, key: "250-*"},
        searchkick_filter: {gte: 25100},
      ),
    ].freeze

    def values
      VALUES
    end

    def to_aggregate
      { ranges: values.map(&:bucket_value) }
    end
  end
end
