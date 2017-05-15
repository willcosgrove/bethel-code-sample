class WinesController < ApplicationController
  include WineSearching

  def index
    @search = WineSearcher.run(search_query,
      searchkick_options: {
        order: search_sort,
        page: page,
        per_page: per_page,
      },
      **search_filters,
    )
    @wines = @search.results
  end
end
