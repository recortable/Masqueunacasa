class Group < Agent 

  attr_accessible :slug

  has_many :posts

  def should_generate_new_friendly_id?
    new_record?
  end
end
