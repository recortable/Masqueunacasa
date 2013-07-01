module SocialHelper
  def render_kudos(model)
    render partial: 'kudos', locals: {model: model}
  end

end
