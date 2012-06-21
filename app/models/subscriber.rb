class Subscriber < ActiveRecord::Base
  attr_accessible :document_id, :document_type
  attr_accessible :user_id

  belongs_to :document, polymorphic: true, counter_cache: true
  belongs_to :user

  validates_presence_of :document_id, :document_type

end
