ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "minitest/autorun"
require "capybara/rails"
require "active_support/testing/setup_and_teardown"

DatabaseCleaner.strategy = :truncation
class MiniTest::Unit::TestCase
  include FactoryGirl::Syntax::Methods

  def setup
    DatabaseCleaner.clean
  end

end
#MiniTest::Unit::TestCase.add_setup_hook { DatabaseCleaner.clean }

class MiniTest::Spec
  include FactoryGirl::Syntax::Methods
  before :each do
    DatabaseCleaner.clean
  end

  def ar_log
    ActiveRecord::Base.logger = Logger.new(STDOUT)
  end
end

class IntegrationTest < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL

  register_spec_type(/integration$/, self)

  before :each do
    subdomain(nil)
    login_user nil
  end

  def subdomain(subdomain)
    host = subdomain.present? ? "http://#{subdomain}.lvh.me" : "http://lvh.me"
    Capybara.app_host = host
  end

  def login_user(user)
    if user.present?
      visit enter_path(user)
    else
      visit logout_path
    end
    user
  end

  def click_submit(name = 'commit')
    page.find("input[name=\"#{name}\"]").click
  end
end

class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior

  register_spec_type(/Helper$/, self)
end

Turn.config.format = :outline


