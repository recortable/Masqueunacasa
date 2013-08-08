module LocationsHelper
  def marker_picture(location)
    if location.resource.class == User
      return {
        picture: image_path('icons/map-usuario.png'),
        width: 18,
        height: 28
      }
    elsif location.resource.class == Group
      return {
        picture: image_path('icons/map-colectivo.png'),
        width: 31,
        height: 31
      }
    elsif location.resource.class == Experiencie
      return {
        picture: image_path('icons/map-experiencia.png'),
        width: 22,
        height: 33
      }
    end
  end
end
