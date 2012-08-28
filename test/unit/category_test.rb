require 'test_helper' 

describe Category do
  it 'name, sulg and title always present in all locales' do
    cat = create(:category)

    cat.name_es.must_be :present?
    cat.name_ca.must_be :present?
    cat.title_es.must_be :present?
    cat.title_ca.must_be :present?
    cat.slug_es.must_be :present?
    cat.slug_ca.must_be :present?
  end

  it 'propagate phases' do
    c = create(:category)
    p = create(:proposal, category: c)
    p.phase.must_equal c.phase

    c.phase = create(:phase)
    c.save
    p.reload
    p.phase.must_equal c.phase
  end
end
