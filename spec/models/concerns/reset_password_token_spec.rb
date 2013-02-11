require 'spec_helper'
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
  person = PersonForResetPasswordToken.new

  it 'builds reset password token' do
    person.build_reset_password_token

    person.reset_password_sent_at.should_not be_nil
    person.reset_password_token.should_not be_nil
  end
end
