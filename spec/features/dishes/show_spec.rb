require 'rails_helper'

RSpec.describe 'Dishes show page' do
# As a visitor
# When I visit a dish's show page
# I see the dish’s name and description
# And I see a list of ingredients for that dish
# and a total calorie count for that dish
# And I see the chef's name.

  describe 'User story 1' do
    it 'displays the dish name, description, ingredients, calorie count, chef name' do
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

      visit "/dishes/#{spaghetti.id}"

      expect(page).to have_content(spaghetti.name)
      expect(page).to have_content(spaghetti.description)
      expect(page).to have_content(sauce.name)
      expect(page).to have_content(pasta.name)
      expect(page).to have_content(meatball.name)
      expect(page).to have_content(tom.name)
      expect(page).to have_content("Total calorie count: #{spaghetti.total_calories}")
      expect(page).to_not have_content(lasagna.name)
      expect(page).to_not have_content(five_cheese.name)
    end
  end
end