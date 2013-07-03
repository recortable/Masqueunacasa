Markitup::Rails.configure do |config|
  config.formatter = -> markup do
    markup.gsub! /^#+/, '### ' if markup.present?
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(markup)
  end
end
