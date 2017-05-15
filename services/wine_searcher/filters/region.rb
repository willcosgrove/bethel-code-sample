module WineSearcher::Filters
  module Region
    extend WineSearcher::Filter
    extend self

    REGION_FILTER_VALUES = Hash.new { |hash, region|
      hash[region] = FilterValue.new(
        human_name: region,
        searchkick_filter: region,
      )
    }

    def values
      Wine.uniq.pluck(:region).compact.sort.map { |region|
        next if region.downcase == "n/a"
        REGION_FILTER_VALUES[region]
      }.compact
    end
  end
end
