module FriendlyId
  # These methods will be added to the model's {FriendlyId::Base#relation_class relation_class}.
  module FinderMethods

    protected

    # FriendlyId overrides this method to make it possible to use friendly id's
    # identically to numeric ids in finders.
    #
    # @example
    #  person = Person.find(123)
    #  person = Person.find("joe")
    #
    # @see FriendlyId::ObjectUtils
    def find_one(id)
      return super if id.unfriendly_id?
      where("slug_es = ? OR slug_ca = ? OR slug_en = ?", id, id, id).first or super
    end

    # FriendlyId overrides this method to make it possible to use friendly id's
    # identically to numeric ids in finders.
    #
    # @example
    #  person = Person.exists?(123)
    #  person = Person.exists?("joe")
    #  person = Person.exists?({:name => 'joe'})
    #  person = Person.exists?(['name = ?', 'joe'])
    #
    # @see FriendlyId::ObjectUtils
    def exists?(id = false)
      return super if id.unfriendly_id?
      super @klass.friendly_id_config.query_field => id
    end
  end

  module History

    # Adds a finder that explictly uses slugs from the slug table.
    module FinderMethods
      # Search for a record in the slugs table using the specified slug.
      def find_one(id)
        return super(id) if id.unfriendly_id?
        where("slug_es = ? OR slug_ca = ? OR slug_en = ?", id, id, id).first or
        with_old_friendly_id(id) {|x| find_one_without_friendly_id(x)} or
        find_one_without_friendly_id(id)
      end
    end
  end
end
