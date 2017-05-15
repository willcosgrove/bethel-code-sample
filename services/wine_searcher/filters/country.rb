module WineSearcher::Filters
  module Country
    extend WineSearcher::Filter
    extend self

    COUNTRY_FILTER_VALUES = Hash.new { |hash, country|
      hash[country] = FilterValue.new(
        human_name: country,
        searchkick_filter: country,
      )
    }

    def values
      Wine.uniq.pluck(:country).compact.sort.map { |country|
        next if country.downcase == "n/a"
        COUNTRY_FILTER_VALUES[country]
      }.compact
    end
  end
end
