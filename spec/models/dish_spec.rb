require 'rails_helper'

RSpec.describe Dish, type: :model do
  describe "validations" do
    it {should validate_presence_of :name}
    it {should validate_presence_of :description}
  end
  describe "relationships" do
    it {should belong_to :chef}
    it {should have_many :dish_ingredients}
    it {should have_many(:ingredients).through(:dish_ingredients)}
  end

  describe 'instance methods' do
    describe "#total_calories" do
      it 'returns the total calorie count for a dish' do
        tom = Chef.create!(name: 'Tom') 
      
        spaghetti = tom.dishes.create!(name: 'spaghetti and meatballs', description: 'pork meatballs with red sauce')
        lasagna = tom.dishes.create!(name: 'lasagna with meat sauce', description: 'can be made with vegetarian')
        ziti = tom.dishes.create!(name: 'baked ziti', description: '5 different cheeses double baked')
  
        sauce = Ingredient.create!(name: 'sauce', calories: 10)
        pasta = Ingredient.create!(name: 'pasta', calories: 400)
        meatball = Ingredient.create!(name: 'meatball', calories: 600)
        cheese = Ingredient.create!(name: 'cheese', calories: 300)
        five_cheese = Ingredient.create!(name: 'five cheese blend', calories: 250)
  
        DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: sauce.id)
        DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: pasta.id)
        DishIngredient.create!(dish_id: spaghetti.id, ingredient_id: meatball.id)

        DishIngredient.create!(dish_id: lasagna.id, ingredient_id: pasta.id)
        DishIngredient.create!(dish_id: lasagna.id, ingredient_id: sauce.id)
        DishIngredient.create!(dish_id: lasagna.id, ingredient_id: cheese.id)

        expect(spaghetti.total_calories).to eq(1010)
        expect(lasagna.total_calories).to eq(710)
      end
    end
  end
end