Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users, skip: [:sessions, :passwords, :registrations], controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end
  root "home#top"
end
