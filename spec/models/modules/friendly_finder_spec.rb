require 'spec_helper'

shared_examples_for FriendlyFinder do |base_attribute_for_slugs|
  context "Finder method find_one overrided" do
    it "finds objects with slugs for other locales" do
      original_locale = T.l

      T.avl.each do |locale|

        T.l = locale

        object = FactoryGirl.create( :"#{described_class.to_s.underscore}" )

        described_class.find("#{object.slug}").should == object

        object.slug_es.should.should == object.slug_ca

        T.avl.each do |l|
          title = object.title + " #{l}"
          T.l = l
          object.update_attributes base_attribute_for_slugs => title
        end

        T.l = locale

        query = "DELETE from friendly_id_slugs"
        ActiveRecord::Base.connection.execute(query)

        object.reload

        T.avl.each do |l|
          finded_object = described_class.find("#{object.send("slug_#{l}")}")
          expect( finded_object ).to eq object
        end
      end

      T.l = original_locale
    end
  end
end

INCLUDED_MODELS = [Proposal, Category, Experiencie, Phase]

INCLUDED_MODELS.each do |klass|
  describe klass do
    it_behaves_like FriendlyFinder, klass.friendly_id_config.base
  end
end
