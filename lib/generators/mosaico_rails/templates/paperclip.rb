require "paperclip/railtie"

Paperclip::Railtie.insert

# Configure upload to s3
# Uncomment and replace all 'XXX' to use your s3 storage

# MosaicoRails::Engine.config.paperclip_defaults = {
# 	use_timestamp: false,
#   storage: :s3,
#   s3_credentials: {
#     bucket: 'XXX',
#     access_key_id: 'XXX',
#     secret_access_key: 'XXX',
#     s3_region: 'XXX'
#   },
#   url: ':s3_domain_url',
#   path: ":attachment/:id_partition/:style/:filename",
#   s3_host_name: "s3-XXX.amazonaws.com"
# }
