require 'spec_helper'

describe ApplicationController do
  context "adds the locale if not present" do

    it "when visiting the home" do
      original_locale = I18n.default_locale
      I18n.available_locales.each do |loc|
        I18n.with_locale(loc) do
          I18n.default_locale = loc
          visit "/"
          expect( current_path ).to eq "/#{I18n.locale}/"
        end
      end
      I18n.default_locale = original_locale
    end

    it "when visiting other pages" do
      original_locale = I18n.default_locale
      I18n.available_locales.each do |loc|
        I18n.with_locale(loc) do
          I18n.default_locale = loc
          visit login_path
          expect( current_path ).to eq "/#{I18n.locale}/#{I18n.t('routes.entrar')}"
        end
      end
      I18n.default_locale = original_locale
    end

    it "and desn't reise a MissingTemplate error when the url does't match any route" do
      url = "/lkjadf/lkjjklj/lkjklj"
      expect { visit url }.to_not raise_error ActionView::MissingTemplate
    end
  end
end
