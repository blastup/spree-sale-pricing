Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :sale_prices
    resources :products do
      resources :sale_prices
    end
  end
end