module HasKudos
  extend ActiveSupport::Concern

  included do
#    attr_accessible :kudos_count
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
      self.kudos.where(ip: ip).first
      if kudo.present?
        kudo.destroy
      else
        self.kudos.create!(ip: ip)
      end
    end
  end
end
