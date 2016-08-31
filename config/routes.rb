RailsMosaico::Engine.routes.draw do
  get   '/editor' => 'email_templates#show'
  post  '/upload' => 'galleries#update'
  get   '/upload' => 'images#index'
  get   '/img'     => 'images#show'
end
