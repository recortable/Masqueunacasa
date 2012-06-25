# Measure model popularity
# The model popularity has two types:
# - Kudos - people saying I like it
# - Page views - number of page views
#
module HasPopularity
  extend ActiveSupport::Concern

  included do
    has_many :kudos, as: :document, dependent: :destroy
  end

  def kudo(user)
    if user.class == User
      kudo = self.kudos.where(user_id: user.id).first
      if kudo.present?
        kudo.destroy
      else
        self.kudos.create!(user_id: user.id)
      end
    else
      ip = user.to_s
      kudo = self.kudos.where(ip: ip).first
      if kudo.present?
        kudo.destroy
      else
        self.kudos.create!(ip: ip)
      end
    end
  end

  # This model has a view counter
  def increment_view_counter
    update_column(:view_count, self.view_count + 1)
  end
end
