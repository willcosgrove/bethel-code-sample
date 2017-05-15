module WineSearcher::Filters
  module Varietal
    extend WineSearcher::Filter
    extend self

    VARIETAL_FILTER_VALUES = Hash.new { |hash, varietal|
      hash[varietal] = FilterValue.new(
        human_name: varietal,
        searchkick_filter: varietal,
      )
    }

    def values
      Wine.uniq.pluck(:varietal).compact.sort.map { |varietal|
        VARIETAL_FILTER_VALUES[varietal]
      }
    end
  end
end
