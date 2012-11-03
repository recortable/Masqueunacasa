class Notice < ActiveRecord::Base
  attr_accessible :title, :list, :body, :embed, :image, :link, :position

  validates_presence_of :title, :list
  validates_uniqueness_of :title

  mount_uploader :image, NoticeImageUploader

  acts_as_list 
  default_scope order: :position
  scope :list, lambda {|l| where(list: l) }

  LISTS = ['inicio', 'habitapedia']


  # scope_condition for acts_as_list
  def scope_condition
    "#{connection.quote_column_name("list")} = #{quote_value(list)}"
  end

  def to_param
    "#{id}-#{title}".parameterize
  end
end
