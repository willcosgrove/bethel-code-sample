module WineSearcher::Filters
  module BottleSize
    extend WineSearcher::Filter
    extend self

    VALUES = [
      FilterValue.new(
        human_name: "9.0L",
        param_name: "9000",
        bucket_key: 9000.0,
      ),
      FilterValue.new(
        human_name: "6.0L",
        param_name: "6000",
        bucket_key: 6000.0,
      ),
      FilterValue.new(
        human_name: "5.0L",
        param_name: "5000",
        bucket_key: 5000.0,
      ),
      FilterValue.new(
        human_name: "1.5L",
        param_name: "1500",
        bucket_key: 1500.0,
      ),
      FilterValue.new(
        human_name: "1L",
        param_name: "1000",
        bucket_key: 1000.0,
      ),
      FilterValue.new(
        human_name: "750mL",
        param_name: "750",
        bucket_key: 750.0,
      ),
      FilterValue.new(
        human_name: "500mL",
        param_name: "500",
        bucket_key: 500.0,
      ),
      FilterValue.new(
        human_name: "375mL",
        param_name: "375",
        bucket_key: 375.0,
      ),
      FilterValue.new(
        human_name: "187mL",
        param_name: "187",
        bucket_key: 187.0,
      ),
    ].freeze

    def values
      VALUES
    end
  end
end
