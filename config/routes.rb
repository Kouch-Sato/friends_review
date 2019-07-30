# == Route Map
#
#                          Prefix Verb     URI Pattern                                                                              Controller#Action
# user_twitter_omniauth_authorize GET|POST /users/auth/twitter(.:format)                                                            users/omniauth_callbacks#passthru
#  user_twitter_omniauth_callback GET|POST /users/auth/twitter/callback(.:format)                                                   users/omniauth_callbacks#twitter
#            destroy_user_session DELETE   /logout(.:format)                                                                        devise/sessions#destroy
#                            root GET      /                                                                                        home#top
#                    home_privacy GET      /home/privacy(.:format)                                                                  home#privacy
#                      home_terms GET      /home/terms(.:format)                                                                    home#terms
#                 reviewed_books GET      /books/reviewed(.:format)                                                               books#reviewed
#                 following_books GET      /books/following(.:format)                                                               books#following
#                      check_book GET      /books/:id/check(.:format)                                                               books#check
#             book_review_replies POST     /books/:book_id/reviews/:review_id/replies(.:format)                                     replies#create
#                    book_reviews POST     /books/:book_id/reviews(.:format)                                                        reviews#create
#                     book_review PATCH    /books/:book_id/reviews/:id(.:format)                                                    reviews#update
#                                 PUT      /books/:book_id/reviews/:id(.:format)                                                    reviews#update
#                                 DELETE   /books/:book_id/reviews/:id(.:format)                                                    reviews#destroy
#                       edit_book GET      /books/:id/edit(.:format)                                                                books#edit
#                            book GET      /books/:id(.:format)                                                                     books#show
#                            user GET      /users/:id(.:format)                                                                     users#show
#                                 DELETE   /users/:id(.:format)                                                                     users#destroy
#                     admin_users GET      /admin/users(.:format)                                                                   admin/users#index
#                      admin_user GET      /admin/users/:id(.:format)                                                               admin/users#show
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
  get "home/privacy"
  get "home/terms"

  # TODO: shallow: trueを使ってネストを浅くする
  # https://railsguides.jp/routing.html#%E3%83%8D%E3%82%B9%E3%83%86%E3%82%A3%E3%83%B3%E3%82%B0%E5%9B%9E%E6%95%B0%E3%81%AE%E4%B8%8A%E9%99%90
  resources :books, only: [:show, :edit] do
    collection do
      get "reviewed"
      get "following"
    end
    member do
      get "check"
    end
    resources :reviews, only: [:create, :update, :destroy] do
      resources :replies, only: [:create]
    end
  end
  resources :users, only: [:show, :destroy]

  namespace :admin do
    resources :users, only: [:index, :show]
  end
end
