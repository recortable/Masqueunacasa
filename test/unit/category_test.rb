require 'test_helper'

describe Category do
  let(:cat) { create(:category) }

  it 'sulg always present in all locales' do
    I18n.available_locales.each do |l|
      cat.send("slug_#{l}").must_be :present?
    end
  end

  it 'propagate phases' do
    p = create(:proposal, category: cat)
    p.phase.must_equal cat.phase

    cat.phase = create(:phase)
    cat.save
    p.reload
    p.phase.must_equal cat.phase
  end

  it "creates a translation" do
    cat.translations.with_locale(I18n.locale).must_be :present?
    cat.translations.size.must_equal 1
  end

  it "has original locale" do
    cat.original_locale.must_equal I18n.locale
  end
end
