class ChefsController < ApplicationController
  def show
    @chef = Chef.find(params[:id])
  end
  
  def update
    # chef = Chef.find(params[:id])
    dish = Dish.find(params[:dish_identification])
    dish.update!(chef_id: params[:id])
    dish.save
    redirect_to "/chefs/#{params[:id]}"
  end
end