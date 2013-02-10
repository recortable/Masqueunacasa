require 'spec_helper'

describe Content do
  let(:content) { create(:content) }

  it "without title is not valid" do
    content.title = ""
    expect(content).not_to be_valid
  end

  it "has slugs for all locales" do
    T.avl.each do |locale|
      expect( content.send("slug_#{locale}").present? ).to be_true
    end
  end

  it "always have published at" do
    expect(content.published_at.present?).to be_true
  end

  it "has original locale" do
    expect(content.original_locale).to eq(T.l)
  end

  it "has translations" do
    tmp_locale = T.avl.reject { |l| l == T.l }.first
    title = content.title
    T.w_l( tmp_locale) {
      content.update_attributes(title: "#{title} #{tmp_locale}")
    }
    expect(content.translations.size).to eq( 2 )
  end
end
