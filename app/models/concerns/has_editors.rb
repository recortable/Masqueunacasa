module HasEditors
  extend ActiveSupport::Concern

  included do
    has_many :editorships, as: :document, dependent: :destroy
    has_many :editors, through: :editorships, source: :user
    after_create :add_owner_as_editor
  end

  def editorship_of(user)
    self.editorships.where(user_id: user.id).first
  end

  def editor?(user)
    editorship_of(user).present?
  end

  def add_editor(user)
    editorship = editorship_of(user)
    editorship ||= self.editorships.create!(user: user)
  end

  protected
  def add_owner_as_editor
    add_editor(self.user)
  end

end
