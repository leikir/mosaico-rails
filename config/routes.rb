RailsMosaico::Engine.routes.draw do
  resource :email_editor, only: :show
  get '/editor', :to => redirect('mosaico/editor.html')

  resources :galleries, only: :update
  resources :images, only: :index
end
