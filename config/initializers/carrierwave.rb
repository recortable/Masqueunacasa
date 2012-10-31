local = ENV['S3_KEY'] ? {} : YAML::load(ERB.new(File.read("#{Rails.root}/config/amazon_s3.yml")).result)[Rails.env]

CarrierWave.configure do |config|
  s3_access_key_id = ENV['S3_KEY'] ? ENV['S3_KEY'] : local['access_key_id']
  s3_secret_access_key = ENV['S3_SECRET'] ? ENV['S3_SECRET'] : local['secret_access_key']
  s3_bucket = ENV['S3_BUCKET'] ? ENV['S3_BUCKET'] : local['bucket']


  config.fog_credentials = {
      :provider => 'AWS',
      :aws_access_key_id => s3_access_key_id,
      :aws_secret_access_key => s3_secret_access_key,
      :region => 'eu-west-1' 
  }
  config.fog_directory = s3_bucket
  config.fog_public = true
  config.asset_host = 'http://archivos.masqueunacasa.org'
end
