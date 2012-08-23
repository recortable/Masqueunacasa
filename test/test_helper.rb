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
    User.current_user = nil
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
    create(:group, name: 'Masqueunacasa', admin: true)
    subdomain(nil)
    visit logout_path
  end

  after :each do
    visit logout_path
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

  def setup_group
    group = create(:group)
    login_user(group.user)
    subdomain(group.subdomain)
    group
  end

  def click_submit(name = 'commit')
    page.find("input[name=\"#{name}\"]").click
  end

  def find_link(rel)
    page.find("a[rel='#{rel}']")
  end
end

class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior

  register_spec_type(/Helper$/, self)
end

Turn.config do |c|
 # use one of output formats:
 # :outline  - turn's original case/test outline mode [default]
 # :progress - indicates progress with progress bar
 # :dotted   - test/unit's traditional dot-progress mode
 # :pretty   - new pretty reporter
 # :marshal  - dump output as YAML (normal run mode only)
 # :cue      - interactive testing
 # c.format  = :outline
 c.format  = :pretty
 # turn on invoke/execute tracing, enable full backtrace
 # c.trace   = true
 # use humanized test names (works only with :outline format)
 # c.natural = true
end

