module VersionsHelper
  def item_type_gender(version)
    case version.item_type
    when 'Agent'
      'el'
    else
      'la'
    end

  end
end
