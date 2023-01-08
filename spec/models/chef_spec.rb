require 'rails_helper'

RSpec.describe Chef, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
  end
  describe "relationships" do
    it {should have_many :dishes}
    it {should have_many(:ingredients).through(:dishes)}
  end

  describe 'instance methods' do
    it 'returns the unique name of ingredients used by this chef' do
      tom = Chef.create!(name: 'Tom') 

      spaghetti = tom.dishes.create!(name: 'spaghetti and meatballs', description: 'pork meatballs with red sauce')
      lasagna = tom.dishes.create!(name: 'lasagna with meat sauce', description: 'can be made with vegetarian')
      ziti = tom.dishes.create!(name: 'baked ziti', description: '5 different cheeses double baked')

      sauce = Ingredient.create!(name: 'sauce', calories: 10)
      pasta = Ingredient.create!(name: 'pasta', calories: 400)
      meatball = Ingredient.create!(name: 'meatball', calories: 600)
      cheese = Ingredient.create!(name: 'cheese', calories: 300)
      five_cheese = Ingredient.create!(name: 'five cheese blend', calories: 250)
      alfredo_sauce = Ingredient.create(name: 'alfredo sauce', calories: 300)

      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id)
      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: meatball.id)

      DishIngredient.create!(dish_id: lasagna.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: lasagna.id, ingredient_id: sauce.id)
      DishIngredient.create!(dish_id: lasagna.id, ingredient_id: cheese.id)

      DishIngredient.create!(dish_id: ziti.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: ziti.id, ingredient_id: sauce.id)
      DishIngredient.create!(dish_id: ziti.id, ingredient_id: five_cheese.id)

      expect(tom.unique_ingredients_used.sort).to eq([cheese.name, five_cheese.name, meatball.name, pasta.name, sauce.name])
    end
  end
end