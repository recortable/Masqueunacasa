module SocialHelper
  def render_social_links(model)
    render partial: 'social_links', locals: {model: model}
  end

  def render_kudos(model)
    render partial: 'kudos', locals: {model: model}
  end

end
