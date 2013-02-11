require 'spec_helper'

describe DashboardController do
  context "adds the locale if not present" do

    it "when visiting the home page without locale" do
      original_locale = I18n.default_locale
      I18n.available_locales.each do |loc|
        I18n.with_locale(loc) do
          I18n.default_locale = loc
          get :welcome
          expect( response ).to redirect_to "/#{I18n.locale}/"
        end
      end
      I18n.default_locale = original_locale
    end
  end
end

describe ApplicationController do
  context "adds the locale if not present" do

    it "when visiting other pages" do
      original_locale = I18n.default_locale
      I18n.available_locales.each do |loc|
        I18n.with_locale(loc) do
          I18n.default_locale = loc
          visit "/#{I18n.t('routes.sign_in')}"
          expect( current_path ).to eq "/#{I18n.locale}/#{I18n.t('routes.sign_in')}"
        end
      end
      I18n.default_locale = original_locale
    end

    it "and desn't reises a MissingTemplate error when the url does't match any route" do
      url = "/lkjadf/lkjjklj/lkjklj"
      expect { visit url }.to_not raise_error ActionView::MissingTemplate
    end
  end
end
