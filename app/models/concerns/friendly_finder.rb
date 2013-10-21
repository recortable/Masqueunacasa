module FriendlyFinder
  def self.included(model_class)
    model_class.instance_eval do
      relation_class.send :include, FinderMethods
    end
  end

  module FinderMethods
    # Search for a record in a table using all locales.
    # If not found search in the friendly_id_slugs table
    def find_one(id)
      return super(id) if id.unfriendly_id?
      where( create_conditions_string(id) ).first or
      with_old_friendly_id(id) {|x| find_one_without_friendly_id(x)} or
      find_one_without_friendly_id(id)
    end

    # Create an array with the condition for a where clause
    # Example: ["slug_es = ? OR slug_ca = ? OR slug_en = ?", id, id, id]
    def create_conditions_string(id)
      array_for_conditions = [I18n.available_locales.map { |l| "slug_#{l} = ?"}.join(" OR ")]
      I18n.available_locales.size.times { array_for_conditions << id }
      array_for_conditions
    end
  end
end

