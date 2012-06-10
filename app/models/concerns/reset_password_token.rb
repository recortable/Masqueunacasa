require 'bcrypt'

module ResetPasswordToken
  
  def build_reset_password_token
    self.reset_password_sent_at = Time.now
    self.reset_password_token = Digest::MD5.hexdigest("#{Random.rand(100)}#{self.id}#{self.reset_password_sent_at}")
  end

end
