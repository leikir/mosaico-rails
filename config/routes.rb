MosaicoRails::Engine.routes.draw do
  get   '/editor' => 'email_templates#editor',      as: :mosaico_editor
  post  '/upload' => 'galleries#update',            as: :mosaico_upload
  get   '/upload' => 'images#index'
  get   '/img'     => 'images#mosailco_rails_show_img',    as: :mosaico_image
  get 	'/templates/:id' => 'email_templates#show', as: :mosaico_template
  get		'/translations/:locale' => 'translations#show'
end
