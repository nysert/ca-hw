class VehicleSearcher
  attr_reader :params, :filters, :joins

  def initialize(params)
    @params = params
    @filters = []
    @joins = []
  end

  def search
    add_model_name_filter
    add_brand_name_filter
    add_year_greater_than_filter
    add_mileage_lower_than_filter
    add_price_lower_than_filter

    query = @filters.map{ |f| f[0] }.join(" AND ")
    query_values = @filters.map{ |f| f[1] }
    Vehicle.includes(@joins).joins(@joins).where(query, *query_values).map{|vehicle|
      {
        id: vehicle.id,
        model_name: vehicle.model.name,
        brand_name: vehicle.model.brand.name,
        year: vehicle.year,
        mileage: vehicle.mileage,
        price: vehicle.price,
      }
    }
  end

  def add_model_name_filter
    model_name = @params["model_name"]
    if model_name
      @joins << :model
      # sqlite doesnt hava an ILIKE function like postgres, so we have to add this statements:
      @filters << ["vehicle_models.name LIKE ?", "#{model_name}%"]
      @filters << ["UPPER(vehicle_models.name) LIKE ?", "#{model_name.upcase}%"]
    end
  end

  def add_brand_name_filter
    brand_name = @params["brand_name"]
    if brand_name
      @joins << [model: [:brand]]
      # sqlite doesnt hava an ILIKE function like postgres, so we have to add this statements:
      @filters << ["vehicle_brands.name LIKE ?", "#{brand_name}%"]
      @filters << ["UPPER(vehicle_brands.name) LIKE ?", "#{brand_name.upcase}%"]
    end
  end

  def add_year_greater_than_filter
    gt_year = @params["gt_year"]
    if gt_year
      @filters << ["vehicles.year > ?", gt_year]
    end
  end

  def add_mileage_lower_than_filter
    lt_mileage = @params["lt_mileage"]
    if lt_mileage
      @filters << ["vehicles.mileage < ?", lt_mileage]
    end
  end

  def add_price_lower_than_filter
    lt_price = @params["lt_price"]
    if lt_price
      @filters << ["vehicles.price < ?", lt_price]
    end
  end
end
