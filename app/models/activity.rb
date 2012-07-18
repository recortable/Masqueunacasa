class Activity
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
