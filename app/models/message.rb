class Message < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource, polymorphic: true
  belongs_to :group
  has_many :replies, class_name: 'Message', foreign_key: 'reply_to_id'
  belongs_to :in_reply_to, class_name: 'Message', foreign_key: 'reply_to_id'

  attr_accessible :user_id, :group_id, :resource_type, :resource_id, :reply_to_id
  attr_accessible :body, :resource, :user

  validates_presence_of :resource_type, :resource_id, :body
end
