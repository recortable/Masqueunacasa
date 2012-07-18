# config/initializers/paper_trail.rb
class Version < ActiveRecord::Base
  attr_accessible :title, :document_title 
  attr_accessible :group_id, :user_name
  attr_accessible :document_type, :document_id

  belongs_to :group
  belongs_to :document, polymorphic: true
end
