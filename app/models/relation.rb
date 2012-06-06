class Relation < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :experiencie
  belongs_to :user

  attr_accessible :experiencie, :proposal, :user

  validates_presence_of :proposal_id, :experiencie_id, :user_id
end
