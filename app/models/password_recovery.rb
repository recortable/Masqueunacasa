# Password Recovery
# Recuperar la contraseña
#
class PasswordRecovery
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :email
  attr_accessor :password, :password_confirmation

  def initialize(token)
    @token = token
    @user = User.find_by_reset_password_token!(token) if token
  end

  def send_email(email)
    user = User.find_by_email(email)
    if user.present?
      user.build_reset_password_token
      user.reset_password_sent_at = Time.now
      user.save
      UserMailer.password_recovery_email(user.id).deliver
      true
    else
      false
    end
  end
  
  def update_password(attributes) 
    @user.password = attributes[:password]
    @user.password_confirmation = attributes[:password_confirmation]
    @user.reset_password_sent_at = nil
    @user.reset_password_token = nil
    @user.save
  end

  def id
    @token
  end
  
  def persisted?
    @token.present?
  end
end
