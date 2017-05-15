module WineSearcher::Filters
  module Vintage
    extend WineSearcher::Filter
    extend self

    PERMANENT_VALUES = [
      FilterValue.new(
        human_name: "1980's",
        param_name: "1980-1989",
        bucket_key: "1980-1989",
        bucket_value: {from: 1980, to: 1990, key: "1980-1989"},
        searchkick_filter: 1980...1990,
      ),
      FilterValue.new(
        human_name: "1970's",
        param_name: "1970-1979",
        bucket_key: "1970-1979",
        bucket_value: {from: 1970, to: 1980, key: "1970-1979"},
        searchkick_filter: 1970...1980,
      ),
      FilterValue.new(
        human_name: "1960's",
        param_name: "1960-1969",
        bucket_key: "1960-1969",
        bucket_value: {from: 1960, to: 1970, key: "1960-1969"},
        searchkick_filter: 1960...1970,
      ),
      FilterValue.new(
        human_name: "1950's and Older",
        param_name: "*-1959",
        bucket_key: "*-1959",
        bucket_value: {to: 1960, key: "*-1959"},
        searchkick_filter: {lt: 1960},
      ),
    ].freeze

    FILTER_VALUE_FOR_YEAR = Hash.new { |hash, year|
      hash[year] = FilterValue.new(
        human_name: year.to_s,
        bucket_key: year.to_s,
        bucket_value: {from: year, to: year + 1, key: year.to_s},
        searchkick_filter: year,
      )
    }

    def values
      dynamic_values + PERMANENT_VALUES
    end

    def to_aggregate
      { ranges: values.map(&:bucket_value) }
    end

    private

    def dynamic_values
      (1990..Time.now.year).map { |year|
        FILTER_VALUE_FOR_YEAR[year]
      }.reverse
    end
  end
end
