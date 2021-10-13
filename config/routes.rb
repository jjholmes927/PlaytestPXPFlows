Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "home#index"

  get "/home", to: "home#index"

  get "/redirectflow", to: "redirect_flow#index"
  get "/redirectflow/success", to: "redirect_flow#success"
  post "/redirectflow", to: "redirect_flow#create"

  get "/billingrequest", to: "billing_request#index"
  get "/billingrequest/success", to: "billing_request#success"
  post "/billingrequest", to: "billing_request#create"


end
