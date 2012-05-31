# Announcement: un anuncio de un grupo
# Son mensajes que envía un participante de un grupo al resto
# de los miembros del mismo grupo
# Sólo los miembros del grupo pueden crear Announcements
class Announcement < ActiveRecord::Base
  belongs_to :user
  belongs_to :group

  attr_accessible :user, :group, :user_id, :group_id
  attr_accessible :scope, :title, :body

  before_validation :set_default_scope
  validates_presence_of :user_id, :group_id, :scope, :title, :body

  # Define a quién se envía el mensaje
  SCOPES = [
    :admin, # Se envía sólo a los administradores
    :members, # Se envía a los administradores y participantes
    :all # Se envía a administradores, participantes y followers <- opción por defecto
  ]

  # Define si el anuncio ha sido enviado por correo electrónico
  def sent?
    self.sent_at.present?
  end

  protected
  def set_default_scope
    self.scope ||= 'all'
  end
end
