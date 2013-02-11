require 'spec_helper'

describe HasPopularity do
  MODELS = [:phase,
            :category,
            :proposal,
            :experiencie]

  it "#{MODELS.to_sentence} have kudos" do
    MODELS.each do |klass|
      doc = FactoryGirl.create( klass )
      expect( doc ).to respond_to :kudos
    end
  end

  it "can kudo with user" do
    user = FactoryGirl.create( :user )
    MODELS.each do |klass|
      doc = FactoryGirl.create( klass )
      doc.kudo user
      expect( doc.kudos.count ).to eq 1
      expect( doc.kudos.first.user ).to eq user
    end
  end

  it "can kudo whith ip" do
    ip = '123.1.1.1'
    MODELS.each do |klass|
      doc = FactoryGirl.create( klass )
      doc.kudo ip
      expect( doc.kudos.count ).to eq 1
      expect( doc.kudos.first.ip ).to eq ip
    end
  end

  it "can unkudo with user" do
    u1 = FactoryGirl.create( :user )
    u2 = FactoryGirl.create( :user )
    MODELS.each do |klass|
      doc = FactoryGirl.create( klass )
      doc.kudo u1
      doc.kudo u2
      expect( doc.kudos.count ).to eq 2
      doc.kudo u1
      expect( doc.kudos.count ).to eq 1
      doc.reload
      expect( doc.kudos.map { |k| k.user } ).to_not include u1
      expect( doc.kudos.map { |k| k.user } ).to include u2
    end
  end

  context "#{MODELS.to_sentence} kudos counter" do
    user = FactoryGirl.create( :user )

    it "adds kudos" do
      MODELS.each do |klass|
        doc = FactoryGirl.create( klass )
        doc.kudo user
        doc.kudo create( :user )
        doc.reload
        expect( doc.kudos_count).to eq 2
      end
    end

    it "substract kudos" do
      MODELS.each do |klass|
        doc = FactoryGirl.create( klass )
        doc.kudo user
        doc.reload
        expect( doc.kudos_count).to eq 1
      end
    end
  end

  context "Kudo count" do
    it "destroy kudos when destroying a document" do
      MODELS.each do |klass|
        doc = FactoryGirl.create( klass )
        doc.kudo '123.1.1.1'
        doc.kudo '123.1.1.2'
        expect( Kudo.count ).to eq 2
        doc.destroy
        expect( Kudo.count ).to eq 0
      end
    end
  end
end
