module DocumentHasEditors
  extend ActiveSupport::Concern

  included do
    after_save :add_current_user_as_editor
  end

  protected
  def add_current_user_as_editor
    if User.current_user.present? && self.document.respond_to?(:add_editor)
      self.document.add_editor(User.current_user) 
    end
  end

end
