module HasSubscriptors
  extend ActiveSupport::Concern

  included do
    has_many :subscribers, as: :document, dependent: :destroy
    has_many :subscriptors, through: :subscribers, source: :user
  end

  def subscription(user)
    self.subscribers.where(user_id: user).first
  end

  def subscriptor?(user)
    subscription(user).present?
  end

  def subscribe(user)
    subscriber = subscription(user)
    subscriber ||= self.subscribers.create!(user_id: user)
  end

  def unsubscribe(user)
    s = subscription(user)
    s.present? ? s.destroy : false
  end
end
