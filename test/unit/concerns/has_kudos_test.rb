require 'test_helper'

describe HasKudos do
  MODELS = [:phase, :category, :proposal, :experiencie ]

  it "has kudos" do
    [:phase].each do |doc_name|
      doc = create(doc_name)
      doc.respond_to?(:kudos).must_equal true
      doc.respond_to?(:kudos_count).must_equal true
    end
  end

  it "has kudo counter" do
    doc = create(:phase)
    user = create(:user)
    doc.kudo(user)
    doc.kudo(create(:user))
    doc.reload
    doc.kudos_count.must_equal 2
    doc.kudo(user)
    doc.reload
    doc.kudos_count.must_equal 1
  end

  it "destroy its kudos" do
    doc = create(:phase)
    doc.kudo('123.1.1.1')
    doc.kudo('123.1.1.2')
    Kudo.count.must_equal 2
    doc.destroy
    Kudo.count.must_equal 0
  end

  it 'can kudo with user' do
    user = create(:user)
    doc = create(:phase)
    doc.kudo(user)
    doc.kudos.count.must_equal 1
    doc.kudos.first.user.must_equal user
  end

  it 'can kudo with ip' do
    doc = create(:phase)
    doc.kudo('127.0.0.1')
    doc.kudos.count.must_equal 1
    doc.kudos.first.ip.must_equal '127.0.0.1'
  end

  it 'can unkudo with user' do
    u1 = create(:user)
    u2 = create(:user)
    doc = create(:phase)
    doc.kudo(u1)
    doc.kudo(u2)
    doc.kudos.count.must_equal 2
    doc.kudo(u1)
    doc.kudos.count.must_equal 1
    doc.kudos.first.user.must_equal u2
  end
end
