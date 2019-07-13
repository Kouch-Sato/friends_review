# == Route Map
#
#                          Prefix Verb     URI Pattern                                                                              Controller#Action
# user_twitter_omniauth_authorize GET|POST /users/auth/twitter(.:format)                                                            users/omniauth_callbacks#passthru
#  user_twitter_omniauth_callback GET|POST /users/auth/twitter/callback(.:format)                                                   users/omniauth_callbacks#twitter
#            destroy_user_session DELETE   /logout(.:format)                                                                        devise/sessions#destroy
#                            root GET      /                                                                                        home#top
#                    book_reviews POST     /books/:book_id/reviews(.:format)                                                        reviews#create
#                 new_book_review GET      /books/:book_id/reviews/new(.:format)                                                    reviews#new
#                            book GET      /books/:id(.:format)                                                                     books#show
#              rails_service_blob GET      /rails/active_storage/blobs/:signed_id/*filename(.:format)                               active_storage/blobs#show
#       rails_blob_representation GET      /rails/active_storage/representations/:signed_blob_id/:variation_key/*filename(.:format) active_storage/representations#show
#              rails_disk_service GET      /rails/active_storage/disk/:encoded_key/*filename(.:format)                              active_storage/disk#show
#       update_rails_disk_service PUT      /rails/active_storage/disk/:encoded_token(.:format)                                      active_storage/disk#update
#            rails_direct_uploads POST     /rails/active_storage/direct_uploads(.:format)                                           active_storage/direct_uploads#create

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  devise_for :users,
             skip: [:sessions, :passwords, :registrations],
             controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  devise_scope :user do
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  root "home#top"
  resources :books, only: [:show, :edit, :update] do
    resources :reviews, only: [:create, :destroy]
  end
  resources :users, only: [:show]
end
