module HasKudos
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
end
