module AnnouncementsHelper
  def announcement_scopes
    [:members, :all]
  end

  def tscope(announcement)
    I18n.t("announcement.scopes.#{announcement.scope}")
  end
end
