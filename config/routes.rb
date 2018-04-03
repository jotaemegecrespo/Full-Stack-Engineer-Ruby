Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: redirect('/comics')
  get '/comics/', to: 'comics#index'
  post '/comics/:id/fav', as: :comic_fav, to: 'comics#fav'
end
