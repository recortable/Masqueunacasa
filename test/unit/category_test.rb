require 'test_helper' 

describe Category do
  it 'title, slg and question always present in all locales' do
    cat = create(:category)

    cat.title_es.must_be :present?
    cat.title_ca.must_be :present?
    cat.slug_es.must_be :present?
    cat.slug_es.must_be :present?
    cat.question_es.must_be :present?
    cat.question_ca.must_be :present?

  end
end
