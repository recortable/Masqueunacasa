class Activities
  def initialize
    @group = Group.root
  end

  def versions
    @versions ||= Activities.clean_versions(Version.where(['created_at > ?', last_mail_at]).order('created_at DESC'))
  end

  def last_mail_at
    self.last_mail_at = Time.now if @group.last_mail_at.blank?
    @group.last_mail_at
  end

  def last_mail_at=(time)
    @group.update_attribute(:last_mail_at, time)
  end

  def updated_at
    updated_at =  @group.last_mailer_try_at
    @group.update_attribute(:last_mailer_try_at, Time.now)
    updated_at
  end

  def deliver?
    (Time.now.to_i - last_mail_at.to_i > 8.hour) && versions.size > 0
  end

  def self.site_activity(max = 50)
    clean_versions(Version.limit(max).order('created_at DESC')) 
  end

  def self.clean_versions(versions)
    prev = nil
    versions.select do |version|
      like_prev = prev && prev.whodunnit == version.whodunnit && prev.item_id == version.item_id && prev.item_type == version.item_type
      prev = version
      !like_prev
    end
  end
end
