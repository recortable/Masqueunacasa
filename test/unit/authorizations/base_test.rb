require 'test_helper'

class SimpleAuth < Authorizations::Base
  def initialize
    can :manage, Post
  end
end

describe Authorizations::Base do
  it 'authorizes instances, classes and arrays' do
    auth = SimpleAuth.new
    auth.can?(:edit, Post).must_equal true
    auth.can?(:edit, create(:post)).must_equal true
    auth.can?(:edit, [create(:post), create(:post)]).must_equal true
  end
end
