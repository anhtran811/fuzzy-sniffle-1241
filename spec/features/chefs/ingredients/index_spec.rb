require 'rails_helper'

RSpec.describe 'Chefs Ingredients Index Page' do
  describe 'User story 3' do
    it 'displays all the ingredients the chef uses' do
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

      visit "/chefs/#{tom.id}/ingredients"

      expect(page).to have_content(sauce.name)
      expect(page).to have_content(pasta.name)
      expect(page).to have_content(sauce.name)
      expect(page).to have_content(cheese.name)
      expect(page).to have_content(five_cheese.name)
      expect(page).to_not have_content(alfredo_sauce.name)
    end
    
    it 'displays a unique name of all ingredients' do 
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

      visit "/chefs/#{tom.id}/ingredients"

      expect(page).to have_content(sauce.name, count: 1)
      expect(page).to have_content(pasta.name, count: 1)
      expect(page).to have_content(meatball.name)
      expect(page).to have_content(five_cheese.name)
      expect(page).to_not have_content(alfredo_sauce.name)
    end
  end

end