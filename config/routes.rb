Rails.application.routes.draw do
  scope "/api/v1" do
    resources :items, only: [:index]
    resources :carts, only: [:create, :show] do
      member do
        post "add/:item_id", to: "carts#add", as: :add
        delete "remove/:item_id", to: "carts#remove", as: :remove
      end
    end
  end
end