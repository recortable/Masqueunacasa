require 'test_helper'

describe 'Experiencies integration' do
  it 'list experiencies' do
    e = create(:experiencie)
    visit experiencies_path
    page.text.must_include e.title
  end

  it 'shows experiencie' do
    e = create(:experiencie)
    visit experiencie_path(e)
    page.text.must_include e.title
    page.text.must_include e.summary
  end

  # RELATIONS (ASSOCIATED PROPOSALS)
  it 'show the associated proposals' do
    experiencie = create(:experiencie)
    proposal = create(:proposal)
    relation = proposal.add_relation(experiencie, create(:user))

    visit experiencie_path(experiencie)
    page.text.must_include proposal.title
  end

  # EXTERNAL LINKS
  it 'show the related links' do
    user = create(:user)
    login_user user
    experiencie = create(:experiencie)
    link = build(:link)
    experiencie.add_link(link, user)

    visit experiencie_path(experiencie)
    page.text.must_include link.title
  end

  it 'can create link if curent_user' do
    user = create(:user)
    login_user user
    experiencie = create(:experiencie)
    
    visit experiencie_path(experiencie)
    find_link 'new-link'
  end

  it 'can create experiencie if user' do
    login_user(create(:user))
    visit experiencies_path
    page.find "a[rel='new-experiencie']"
  end

  it 'can create experiencie' do
    login_user create(:user)
    visit new_experiencie_path
    fill_in 'experiencie_title', with: 'The title'
    click_submit
    e = Experiencie.last
    e.title.must_equal 'The title'
  end

  it 'can update experiencie' do
    login_user create(:user)
    e = create(:experiencie)
    visit edit_experiencie_path(e)
    fill_in 'experiencie_title', with: 'My experiencie'
    click_submit
    e.reload
    e.title.must_equal 'My experiencie'
  end
end
