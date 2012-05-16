# config/initializers/paper_trail.rb
class Version < ActiveRecord::Base
  attr_accessible :title, :group_id, :user_name

  belongs_to :group
end
