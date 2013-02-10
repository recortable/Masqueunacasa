require 'spec_helper'

describe Category do

  let(:cat) { create(:category) }

  it "is valid" do
    expect( cat ).to be_valid
  end

  it "without title or name is not valid" do
    cat.title = ""
    expect( cat ).not_to be_valid
  end

  it "has translations" do
    cat.translations.with_locale(T.l).present?.should be_true
    expect( cat.translations.size ).to eq( 1 )
  end

  it "has slugs for all locales" do
    T.avl.each do |locale|
      expect( cat.send("slug_#{locale}").present? ).to be_true
    end
  end

  it "has original locale" do
    expect( cat.original_locale ).to eq( T.l )
  end

  it "propagate phases" do
    p = FactoryGirl.create(:proposal, category: cat)
    expect( p.phase).to eq( cat.phase )

    cat.phase = FactoryGirl.create(:phase)
    cat.save
    p.reload
    expect( p.phase).to eq( cat.phase )
  end
end
