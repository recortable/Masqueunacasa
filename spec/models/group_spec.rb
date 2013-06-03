require 'spec_helper'

describe Group do
  let( :group ) { create( :group ) }

  it 'is valid' do
    expect( group ).to be_valid
  end

  it 'without name is not valid' do
    group.name = " "
    expect( group ).not_to be_valid
  end

  it 'without title is not valid' do
    group.title = " "
    expect( group ).not_to be_valid
  end

  it 'without summary is not valid' do
    group.summary = "   "
    expect( group ).not_to be_valid
  end
end
