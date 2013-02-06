module SlugRedirections
  extend ActiveSupport::Concern

  included do
    before_filter only: [:index, :new, :show, :edit] { redirect_to_correct_slug if @locale_changed }
  end

  private

  def redirect_to_correct_slug
    new_url = request.fullpath.dup
    locale = params[:locale]

    for param in params.select { |k, v| (k == 'id' || k.to_s.include?("_id")) and (v.match('\D+').present?) }
      key = param[0]
      value = param[1]
      if key == 'id'
        resource = params[:controller].classify.constantize.find(value)
        @resource = "SLUG_#{locale} => " + resource.send("slug_#{locale}")
      else
        resource = key.gsub("_id", "").classify.constantize.find(value)
      end
      new_url.gsub!("/#{value}", "/" + resource.send("slug_#{locale}") )
    end

    if request.fullpath != new_url
      return redirect_to(new_url, status: :moved_permanently)
    end
  end
end
