module SlugRedirections
  extend ActiveSupport::Concern

  included do
    before_filter only: [:index, :new, :show, :edit] do
      redirect_to_correct_slug unless controller_name == "password_recoveries"
    end
  end

  private

  def redirect_to_correct_slug
    new_url = request.fullpath.dup

    # Recoge todos los parámetros en los que la clave es 'id' o
    # contiene '_id' y en los que el valor contenga un carácter no
    # numérico
    params_with_slugs = params.select do |k, v|
      ( k == 'id' || k.include?('_id') ) and v.match('\D+').present?
    end

    # Se recorren los parámetros y se buscan los slugs
    # correctos de cada objeto, cambiándolos en la url
    params_with_slugs.each do |param|
      key = param[0]
      value = param[1]
      if key == 'id'
        resource = params[:controller].classify.constantize.find(value)
      else
        resource = key.gsub('_id', '').classify.constantize.find(value)
      end
      new_url.sub!("/#{value}", "/" + resource.send('slug') ) if resource.respond_to?('slug')
    end

    # Redireccionamos si la url resultante es diferente de la de la
    # petición
    if request.fullpath != new_url
      return redirect_to(new_url, status: :moved_permanently)
    end
  end
end
