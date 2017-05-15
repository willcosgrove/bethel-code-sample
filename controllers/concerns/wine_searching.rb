module WineSearching
  extend ActiveSupport::Concern

  private

  def search_filters
    {
      bottle_size: params[:bottle_size],
      country:     params[:country],
      price:       params[:price],
      region:      params[:region],
      score:       params[:score],
      varietal:    params[:varietal],
      vintage:     params[:vintage],
    }.reject { |k, v| v.blank? }
  end

  def search_query
    params[:search].presence || "*"
  end

  def search_sort
    field, order = (params[:sort_by].presence || "name-asc").split("-")

    case field
    when "price"   then { "in_stock_prices": { "order": order, "mode": "min" } }
    when "vintage" then { "vintage":         { "order": order } }
    when "name"    then { "name":            { "order": order } }
    end
  end

  def page
    params[:page]
  end

  def per_page
    params[:per_page].presence&.to_i || 25
  end
end
