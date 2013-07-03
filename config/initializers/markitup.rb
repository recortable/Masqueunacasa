Markitup::Rails.configure do |config|
  config.formatter = -> markup do
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markup)
  end
end
