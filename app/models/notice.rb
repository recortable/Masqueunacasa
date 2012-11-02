class Notice < ActiveRecord::Base
  attr_accessible :title, :list, :body, :embed

  validates_presence_of :title, :list

  acts_as_list 
  default_scope order: :position
  scope :list, lambda {|l| where(list: l) }

  LISTS = ['inicio', 'habitapedia']


  # scope_condition for acts_as_list
  def scope_condition
    "#{connection.quote_column_name("list")} = #{quote_value(list)}"
  end
end
