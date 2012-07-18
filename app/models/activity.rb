class Activity
  def self.site_activity
    clean_versions(Version.limit(50).order('created_at DESC')) 
  end

  def self.clean_versions(versions)
    prev = nil
    clean = []
    versions.each do |version|
      unless prev && prev.whodunnit == version.whodunnit && prev.item_id == version.item_id && prev.item_type == version.item_type
        clean << version
      end
      prev = version
    end
    clean
  end
end
