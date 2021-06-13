require "test_helper"

class VehicleModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vehicle_model = vehicle_models(:one)
  end

  test "should create vehicle_model and a vehicle_brand" do
    assert_difference ->{ VehicleModel.count } => 1, ->{ VehicleBrand.count } => 1 do
      post vehicle_models_url, params: { brand: "three", name: "three" }, as: :json
    end

    assert_response 201
  end

  test "should create vehicle_model but not a vehicle_brand" do
    assert_difference ->{ VehicleModel.count } => 1, ->{ VehicleBrand.count } => 0 do
      post vehicle_models_url, params: { brand: vehicle_brands(:one).name, name: "four" }, as: :json
    end

    assert_response 201
  end

  test "should not create vehicle_model with repeated name" do
    post vehicle_models_url, params: { brand: vehicle_brands(:one), name: @vehicle_model.name }, as: :json
    res = JSON.parse(@response.body)
    assert res["name"] == ["has already been taken"]
    assert_response 422
  end
end
