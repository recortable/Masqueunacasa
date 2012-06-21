module SocialDocument
  extend ActiveSupport::Concern

  included do
    has_many :kudos, as: :document, dependent: :destroy
    has_many :subscribers, as: :document, dependent: :destroy
    has_many :subscriptors, through: :subscribers, source: :user
  end
  
  include HasSubscriptors
  include HasKudos

  def increment_view_counter
    update_column(:view_count, self.view_count + 1)
  end
end
