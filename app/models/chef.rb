class Chef < ApplicationRecord
  validates_presence_of :name
  has_many :dishes
  has_many :ingredients, through: :dishes, dependent: :destroy


  def unique_ingredients_used
    self.ingredients.distinct.pluck(:name)
  end
end