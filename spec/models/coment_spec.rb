require 'spec_helper'

describe Comment do
  let( :comment ) { create :comment }

  it { expect( comment.respond_to?('user') ).to be_true }
  it { expect( comment.respond_to?('document') ).to be_true }

  describe 'validations:' do
    it 'without user is not valid' do
      comment2 = FactoryGirl.build(:comment, user: nil)
      expect( comment2 ).not_to be_valid
    end

    it 'without document is not valid' do
      comment2 = FactoryGirl.build(:comment, document: nil)
      expect( comment2 ).not_to be_valid
    end
  end
end
