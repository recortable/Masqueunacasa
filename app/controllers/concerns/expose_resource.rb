module ExposeResource
  extend ActiveSupport::Concern

  module ClassMethods
    # Select a parent from a selection
    # For example:
    # expose_parent(:document, [:proposal, :page])
    # will create an expose(:document) that returns a proposal
    # if proposal_id is given, or a page if a page_id is given
    # Otherwise throws an ActiveRecord::RecordNotFoundException
    def expose_parent(name, names) 
      expose(name) do
        parent_name = names.find {|n| params["#{n}_id"].present? }
        throw ActiveRecord::RecordNotFound.new unless parent_name
        klass = parent_name.to_s.camelcase.constantize
        klass.find(params["#{parent_name}_id"])
      end
    end

  end
end
