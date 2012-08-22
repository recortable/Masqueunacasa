module HasEditors
  extend ActiveSupport::Concern

  included do
    has_many :editorships, as: :document, dependent: :destroy
    has_many :editors, through: :editorships, source: :user
    after_save :add_current_user_as_editor
  end

  def editorship_of(user)
    self.editorships.where(user_id: user.id).first
  end

  def editor?(user)
    editorship_of(user).present?
  end

  def add_editor(user)
    if user
      editorship = editorship_of(user)
      editorship ||= self.editorships.create!(user: user)
    end
  end

  protected
  def add_current_user_as_editor
    add_editor(User.current_user) 
  end

end
