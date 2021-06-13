require "test_helper"

class VehiclesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle = vehicles(:one)
    @model = @vehicle.model
    @brand = @model.brand
  end

  test "should create vehicle and a vehicle_model" do
    assert_difference ->{ Vehicle.count } => 1, ->{ VehicleModel.count } => 1 do
      post vehicles_url, params: { mileage: 1, brand: "three", model: "three", price: 3, year: 3000 }, as: :json
    end

    assert_response 201
  end

  test "should create vehicle but not a vehicle_model" do
    assert_difference ->{ Vehicle.count } => 1, ->{ VehicleModel.count } => 0 do
      post vehicles_url, params: { mileage: 4, brand: @brand.name, model: @model.name, price: 4, year: 4000 }, as: :json
    end

    assert_response 201
  end
end
