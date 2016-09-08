require "paperclip/railtie"

Paperclip::Railtie.insert

Paperclip::Attachment.default_options[:use_timestamp] = false

# Uploading file to s3
# You will need to add gem 'aws-sdk', '~> 2.3' into your Gemfile and
# complete settings below this line

# Paperclip::Attachment.default_options[:path] = ":class/:attachment/:id_partition/:style/:filename"
# Paperclip::Attachment.default_options[:s3_host_name] = "s3-#{ENV.fetch('UPLOAD_BUCKET_S3_REGION')}.amazonaws.com"

# MosaicoRails::Engine.configure do
#   config.paperclip_defaults = {
#     storage: :s3,
#     s3_region: ENV.fetch('UPLOAD_BUCKET_S3_REGION'),
#     s3_credentials: {
#       bucket: ENV.fetch('UPLOAD_BUCKET_S3_NAME'),
#       access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
#       secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY')
#     }
#   }
# end
