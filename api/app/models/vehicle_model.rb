class VehicleModel < ApplicationRecord
  belongs_to :brand, class_name: 'VehicleBrand', foreign_key: 'brand_id'
  has_many :vehicles, class_name: 'Vehicle', foreign_key: 'model_id', dependent: :destroy

  validates :name, uniqueness: true
  validates_presence_of :name
  validates_presence_of :brand
end
