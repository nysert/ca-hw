class VehicleBrand < ApplicationRecord
  has_many :models, class_name: 'VehicleModel', foreign_key: 'brand_id', dependent: :destroy
  validates_presence_of :name
end
