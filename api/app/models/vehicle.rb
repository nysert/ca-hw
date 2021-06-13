class Vehicle < ApplicationRecord
  belongs_to :model, class_name: 'VehicleModel', foreign_key: 'model_id'

  validates_presence_of :model
  validates_presence_of :year
  validates_numericality_of :year, greater_than_or_equal_to: 1886
  validates_presence_of :price
  validates :price, numericality: { greater_than: 0 }
end
