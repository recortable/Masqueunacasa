class Kudo < ActiveRecord::Base
  attr_accessible :document_id, :document_type
  attr_accessible :user_id, :ip

  validates_presence_of :document_id, :document_type

  belongs_to :document, polymorphic: true, counter_cache: :kudos_count 
  belongs_to :user

end
