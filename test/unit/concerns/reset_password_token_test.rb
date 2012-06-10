require "minitest/autorun"
require './app/models/concerns/reset_password_token'

class PersonForResetPasswordToken
  attr_accessor :reset_password_sent_at
  attr_accessor :reset_password_token

  include ResetPasswordToken

  def id
    Random.rand(100)
  end
end

describe ResetPasswordToken do
  subject { PersonForResetPasswordToken.new }

  it 'build reset password token' do
    subject.build_reset_password_token

    subject.reset_password_sent_at.wont_be :nil?
    subject.reset_password_token.wont_be :nil?
  end
end
