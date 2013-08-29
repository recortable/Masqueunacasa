module LocationsHelper
  def marker_picture(location)
    if location.resource.class == User
      return {
        picture: image_path('icons/map-usuario.png'),
        width: 32,
        height: 37
      }
    elsif location.resource.class == Group
      return {
        picture: image_path('icons/map-colectivo.png'),
        width: 32,
        height: 37
      }
    elsif location.resource.class == Experiencie
      return {
        picture: image_path('icons/map-experiencia.png'),
        width: 32,
        height: 37
      }
    end
  end
end
