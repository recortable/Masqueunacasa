module LocationsHelper
  def marker_picture(location)
    if location.resource.class == User
      return {
        picture: image_path('icons/map-usuario.png'),
        width: 15,
        height: 30
      }
    elsif location.resource.class == Group
      return {
        picture: image_path('icons/map-colectivo.png'),
        width: 15,
        height: 30
      }
    elsif location.resource.class == Experiencie
      return {
        picture: image_path('icons/map-experiencia.png'),
        width: 15,
        height: 30
      }
    end
  end
end
