Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/dishes/:id', to: 'dishes#show'
  
  patch '/chefs/:id/dishes', to: 'chefs#update'
  get '/chefs/:id', to: 'chefs#show'

end
