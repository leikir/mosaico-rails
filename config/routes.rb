MosaicoRails::Engine.routes.draw do
  get   '/editor' => 'email_templates#editor',      as: :mosaico_editor
  post  '/upload' => 'galleries#update',            as: :mosaico_upload
  get   '/upload' => 'galleries#show'
  get   '/img'    => 'images#show',    as: :mosaico_image
  get 	'/templates/:id' => 'email_templates#show', as: :mosaico_template
  get		'/translations/:locale' => 'translations#show'
end
