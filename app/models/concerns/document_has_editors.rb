module DocumentHasEditors
  extend ActiveSupport::Concern

  included do
    after_save :add_current_user_as_editor
  end

  protected
  def add_current_user_as_editor
    self.document.add_editor(User.current_user) if self.document.respond_to?(:add_editor)
  end

end
