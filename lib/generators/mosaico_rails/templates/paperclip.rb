require "paperclip/railtie"

Paperclip::Railtie.insert

Paperclip::Attachment.default_options[:use_timestamp] = false

# Fill this form and install gem 'aws-sdk' for uploading files to S3
#
# Rails.application.configure do |config|
#   config.paperclip_defaults = {
#     storage: :s3,
#     s3_credentials: {
#       bucket: ENV.fetch('UPLOAD_BUCKET_S3_NAME'),
#       access_key_id: ENV.fetch('AWS_ACCESS_KEY_ID'),
#       secret_access_key: ENV.fetch('AWS_SECRET_ACCESS_KEY'),
#       s3_region: ENV.fetch('UPLOAD_BUCKET_S3_REGION'),
#     }
#   }
# end
