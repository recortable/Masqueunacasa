# Clase UserSession
#
# Esto es para que veas, sobretodo, que no todos los modelos tienen
# que tener equivalencia en base de datos.
# Este modelo no se guarda en la base de datos, pero tiene validaciones y algunas
# cosas más para que se puedan usar en formularios y tal.
class UserSession
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email, :password
  attr_reader :user
  validates :name, presence: true
  validates :password, presence: true
  validates :email, presence: true

  def initialize(attributes = {})
    if attributes
      attributes.each do |name, value|
        send("#{name}=", value)
      end
    end
    @created = false
  end

  def create
    user = User.find_by_email(@email)
    if user && user.authenticate(@password)
      @user = user
      @created = true
    else
      @created = false
    end
    @created
  end


  def persisted?
    @created
  end
end