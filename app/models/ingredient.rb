class Ingredient < ApplicationRecord
  has_many :dish_ingredients, dependent: :destroy
  has_many :dishes, through: :dish_ingredients, dependent: :destroy
  has_many :chefs, through: :dishes, dependent: :destroy
end