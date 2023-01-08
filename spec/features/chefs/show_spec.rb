require 'rails_helper'

RSpec.describe 'Chef show page' do
  #  As a visitor
  # When I visit a chef's show page
  # I see the name of that chef
  # and I see a list of all dishes that belong to that chef
  # and I see a form to add an existing dish to that chef
  # When I fill in the form with the ID of a dish that exists in the database
  # And I click Submit
  # Then I am redirected to that chef's show page
  # And I see the dish is now listed. 

  describe 'User story 2' do
    it 'displays the name, list of their dishes' do
      tom = Chef.create!(name: 'Tom') 
      laura = Chef.create!(name: 'Laura') 

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

      DishIngredient.create!(dish_id: ziti.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: ziti.id, ingredient_id: sauce.id)
      DishIngredient.create!(dish_id: ziti.id, ingredient_id: five_cheese.id)

      visit "/chefs/#{tom.id}"

      expect(page).to have_content(tom.name)
      expect(page).to have_content(spaghetti.name)
      expect(page).to have_content(lasagna.name)
      expect(page).to have_content(ziti.name)
      expect(page).to_not have_content(laura.name)
    end

    it 'has a form to add a dish to this chef' do
      tom = Chef.create!(name: 'Tom') 
      laura = Chef.create!(name: 'Laura') 

      spaghetti = tom.dishes.create!(name: 'spaghetti and meatballs', description: 'pork meatballs with red sauce')
      lasagna = tom.dishes.create!(name: 'lasagna with meat sauce', description: 'can be made with vegetarian')
      ziti = tom.dishes.create!(name: 'baked ziti', description: '5 different cheeses double baked')
      alfredo = laura.dishes.create!(name: 'alfredo', description: '5 different cheeses double baked')
      
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

      DishIngredient.create!(dish_id: ziti.id, ingredient_id: pasta.id)
      DishIngredient.create!(dish_id: ziti.id, ingredient_id: sauce.id)
      DishIngredient.create!(dish_id: ziti.id, ingredient_id: five_cheese.id)

      visit "/chefs/#{tom.id}"

      expect(page).to have_content(lasagna.name)
      expect(page).to have_content(spaghetti.name)
      expect(page).to have_content(ziti.name)
      expect(page).to_not have_content(alfredo.name)

      fill_in('Dish identification', with: alfredo.id)
      click_on ('Add dish')
      expect(page).to have_content(lasagna.name)
      expect(page).to have_content(spaghetti.name)
      expect(page).to have_content(ziti.name)
      expect(page).to have_content(alfredo.name)
      expect(current_path).to eq("/chefs/#{tom.id}")
    end
  end

  describe 'User story 3' do
# As a visitor
# When I visit a chef's show page
# I see a link to view a list of all ingredients that this chef uses in their dishes.
# When I click on that link
# I'm taken to a chef's ingredients index page
# and I can see a unique list of names of all the ingredients that this chef uses.

    it 'has a link to all the ingredients this chef uses in their dishes' do
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

      visit "/chefs/#{tom.id}"

      within("#all_ingredients_#{tom.id}") do
        expect(page).to have_link('All ingredients', :href => "/chefs/#{tom.id}/ingredients")

        click_link('All ingredients')
        expect(current_path).to eq("/chefs/#{tom.id}/ingredients")
      end
    end
  end
end