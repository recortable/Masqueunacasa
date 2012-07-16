module HasMemberships
  extend ActiveSupport::Concern

  included do
    has_many :memberships
    has_many :users, through: :memberships
    has_many :members, through: :memberships, source: :user
    after_create :create_owner_membership
  end

  # Add a member to a group if not present
  def add_member(user, level = 'member')
    m = membership_for(user)
    m ||= Membership.create!(group: self, user: user, state: level)
  end

  def member_level?(user, levels) 
    m = membership_for(user)
    return false if m.blank?

    level = m.state.to_sym
    if levels.kind_of?(Array)
      levels.include?(level)
    else
      levels.to_sym == level 
    end
  end

  # Check if a user is member
  def member?(user)
    membership_for(user).present?
  end

  def membership_for(user)
    return nil if user.blank?
    Membership.where(group_id: self.id, user_id: user.id).first
  end

  private
  def create_owner_membership
    Membership.create!(group: self, user: self.user, state: 'owner')
  end
end
