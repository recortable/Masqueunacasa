module HasEditors
  extend ActiveSupport::Concern

  included do
    has_many :editeds, as: :document, dependent: :destroy
    has_many :editors, through: :editeds, source: :user
  end

  def edited(user)
    self.editeds.where(user_id: user.id).first
  end

  def edited?(user)
    edited(user).present?
  end

  def add_editor(user)
    edited = edited(user)
    edited ||= self.editers.create!(user: user)
  end

  def remove_editor(user)
    edited = edited(user)
    edited.present? ? edited.destroy : false
  end
end
