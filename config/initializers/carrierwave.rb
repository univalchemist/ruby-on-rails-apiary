CarrierWave.configure do |config|
  if Rails.env.test? || Rails.env.cucumber? || Rails.env.development?
    config.root = "#{Rails.root}/tmp/"
    config.storage = :file
    config.enable_processing = false
  else
    break if ENV['AWS_ACCESS_KEY_ID'].blank? || ENV['AWS_SECRET_ACCESS_KEY'].blank? ||
             ENV['S3_BUCKET_NAME'].blank?
    config.storage = :fog
    config.fog_credentials = {
      provider: 'AWS',
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY']
    }
    config.fog_directory  = ENV['S3_BUCKET_NAME']
  end
end
