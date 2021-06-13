class VehicleModel < ApplicationRecord
  belongs_to :brand, class_name: 'VehicleBrand', foreign_key: 'brand_id'

  validates :name, uniqueness: true
  validates_presence_of :name
  validates_presence_of :brand
end
