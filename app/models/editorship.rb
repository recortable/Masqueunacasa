class Editorship < ActiveRecord::Base
  attr_accessible :document, :user

  belongs_to :document, polymorphic: true, counter_cache: true
  belongs_to :user

  validates_presence_of :document_id, :document_type
#  validates_uniqueness_of :user_id, scope: [:document_id, :document_type]
end
