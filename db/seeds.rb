# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Dish.destroy_all
Chef.destroy_all
Ingredient.destroy_all
DishIngredient.destroy_all

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

DishIngredient.create!(dish_id: ziti.id, ingredient_id: pasta.id)
DishIngredient.create!(dish_id: ziti.id, ingredient_id: sauce.id)
DishIngredient.create!(dish_id: ziti.id, ingredient_id: five_cheese.id)
