class Activities
  def initialize
    @group = Group.root
  end

  def activity_users
    @activity_users ||= Group.root.users
  end

  def versions
    @versions ||= Activities.clean_versions(Version.where(['created_at > ?', last_mail_at]).order('created_at DESC'))
  end

  def last_mail_at
    self.last_mail_at = Time.now if @group.last_mail_at.blank?
    @group.last_mail_at
  end

  def last_mail_at=(time)
    PaperTrail.enabled = false
    @group.update_attribute(:last_mail_at, time)
    PaperTrail.enabled = true
    time
  end

  def updated_at
    PaperTrail.enabled = false
    updated_at =  @group.last_mailer_try_at
    @group.update_attribute(:last_mailer_try_at, Time.now)
    PaperTrail.enabled = true
    updated_at
  end

  def deliver?
    time_since(last_mail_at) > 4.hour && versions.size > 0 && time_since(versions.first.created_at) > 10.minutes
  end

  def time_since(time)
    Time.now.to_i - time.to_i
  end

  def self.user_activity(user, max = 10)
    prepare(Version.where(whodunnit: user.id.to_s), max)
  end

  def self.site_activity(max = 20)
    prepare(Version.scoped, max)
  end

  def self.prepare(versions, max = 50)
    clean_versions versions.includes(:user).limit(max).reorder('created_at DESC')
  end

  def self.clean_versions(versions)
    prev = nil
    versions.select do |version|
      like_prev = prev && prev.whodunnit == version.whodunnit && prev.event == version.event && prev.item_id == version.item_id && prev.item_type == version.item_type 
      prev = version
      !like_prev
    end
  end

  # Devuelve las versiones (limpias) de un documento dado
  def self.document_activity(document, options = {})
    options.reverse_merge! limit: 30

    versions = Version.arel_table
    query = versions[:item_type].eq(document.class.to_s).
      and( versions[:item_id].eq(document.id) )

    section_ids = document.sections.map(&:id)
    query = query.or(versions[:item_type].eq('Section').
                     and(versions[:item_id].in_any(section_ids)))

    if document.respond_to?(:tasks)
      tasks_ids = document.tasks.map(&:id)
      query = query.or(versions[:item_type].eq('Task').
                       and(versions[:item_id].in_any(tasks_ids)))
    end

    versions = Version.where(query).order('id DESC').limit(options[:limit])
    Activities.clean_versions(versions)
  end

end
