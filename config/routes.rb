Rails.application.routes.draw do
	namespace :admin, module: nil  do
    root "admin#index"
    resources :users

  end

  devise_for :users
  resources :categories
  resources :events
  # resource :calendar, only: :to_icalendar
  resource :meetings, only: :show

  get 'admin/index'
  # get 'meetings/show' =>  "meetings#show"

  root 'events#index'

  get 'events/:id/allevent_details' => "events#allevent_details"


  # resources :categories
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

