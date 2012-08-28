require 'test_helper'

describe Version do
  it 'version created by category' do
    c = create(:category)
    verify(c, title: c.title)
  end

  it 'version created by experiencie' do
    e = create(:experiencie)
    verify(e, title: e.title)
  end

  it 'version created by proposal' do
    p = create(:proposal)
    verify(p, title: p.title)
  end

  it 'version created by section' do
    p = create(:proposal)
    s = create(:section, title: 'Sectitle', document: p)
    verify(s, title: s.title, parent_title: p.title, document: p)
    s.title = nil
    s.save
    verify(s, title: s.position.to_s)
  end

  it 'version created by task' do
    t = create(:task)
    verify(t, title: t.title, parent_title: t.document.title, document: t.document)
  end

  it 'version created by link' do
    p = create(:proposal)
    t = create(:link, document: p)
    verify(t, title: t.title, parent_title: p.title, document: p)
  end

  it 'version creted by image' do
    i = create(:image)
    verify(i, title: i.title, parent_title: i.imageable.title, document: i.imageable)

  end

  it 'version created by post' do
    p = create(:post)
    verify(p, title: p.title, group: p.group)
  end

  it 'version created by page' do
    p = create(:page)
    verify(p, title: p.title, group: p.group)
  end

  it 'version created by group' do
    g = create(:group)
    verify(g, title: g.title, group: g)
  end

  protected
  def verify(model, options = {})
    options.reverse_merge! title: nil, parent_title: nil, document: nil, group: nil

    v = Version.last
    v.item.must_equal model 

    v.item_type.must_equal options[:item_type] if options[:item_type]
    v.title.must_equal options[:title] if options[:title]
    v.parent_title.must_equal options[:parent_title] if options[:parent_title]
    v.document.must_equal options[:document] if options[:document]
    v.group.must_equal options[:group] if options[:group]
  end
end
