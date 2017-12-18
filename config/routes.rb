Rails.application.routes.draw do

resources :messages do
  member do
    put :archive
  end
  collection do
    put :archive_all
  end
end

devise_for :users

devise_scope :user do
  authenticated :user do
    root 'messages#index', as: :authenticated_root
  end

  unauthenticated do
    root 'devise/sessions#new', as: :unauthenticated_root
  end
end
end
