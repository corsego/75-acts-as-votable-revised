Rails.application.routes.draw do
  resources :messages do
    member do
      patch :upvote
      patch :downvote
      patch :vote
      patch :bookmark
    end
  end
  devise_for :users
  get 'dashboard', to: 'static_pages#dashboard'
  root "static_pages#landing_page"
end
