require 'spec_helper'

shared_examples_for HasTranslations do

  it "has original locale" do
    original_locale = T.l

    T.avl.each do |locale|
      T.l = locale
      object = FactoryGirl.create( :"#{described_class.to_s.underscore}" )
      expect( object.original_locale ).to eq locale
    end

    T.l = original_locale
  end

  it "the locale fallback for records is its original locale" do
    original_locale = T.l  # caches the initial locale

    T.avl.each do |locale|
      T.l = locale # sets temporal locale, creates a record with this locale
      object = FactoryGirl.create( :"#{described_class.to_s.underscore}" )
      original_title = object.title

      expect( object.translations.with_locale( T.l ) ).to exist

      # default locale is not the same as I18n.locale
      T.dfl = T.avl.reject { |l| l == T.l }.first
      expect( I18n.default_locale ).to_not eq locale

      # Updates the object using the default locale, with a unique title
      T.l = T.dfl
      expect( I18n.default_locale ).to eq I18n.locale
      title_with_default_locale = "new title #{locale}-#{T.l}"
      expect( object.update_attributes title: title_with_default_locale ).to be true
      object.reload
      expect( object.title ).to eq title_with_default_locale
      expect( object.translations.size ).to eq 2
      expect( object.translations.with_locale( T.l ) ).to exist

      # sets another locale, diferent from default locale and the locale we created the objec with,
      # the object has no translation for this locale
      T.l = T.avl.reject { |l| l == T.dfl or l == locale }.first

      expect( object.translations.with_locale( T.l ) ).to_not exist
      expect( object.title ).to eq original_title
      expect( object.title ).to_not eq title_with_default_locale
    end

    T.l = original_locale
  end
end

describe "Models with translations" do
  included_models = [Proposal, Category, Experiencie, Phase]

  included_models.each do |klass|
    describe klass do
      it_behaves_like HasTranslations
    end
  end
end
