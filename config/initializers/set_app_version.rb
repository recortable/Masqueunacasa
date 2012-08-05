# http://www.rubyflow.com/items/8007-how-to-bust-your-rails-etag-cache-on-deployment

revision_file = Rails.root.join("REVISION")
if File.exist?(revision_file)
  ENV["RAILS_APP_VERSION"] = File.read(revision_file)
else
  ENV["RAILS_APP_VERSION"] = Time.now.to_s
end
