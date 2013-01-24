module ExposeResource
  extend ActiveSupport::Concern

  module ClassMethods
    # Select a parent from a selection
    # For example:
    # expose_parent(:document, [:proposal, :page])
    # will create an expose(:document) that returns a proposal
    # if proposal_id is given, or a page if a page_id is given
    # Otherwise throws an ActiveRecord::RecordNotFoundException
    def expose_parent(name, names, options = {}) 
      options.reverse_merge!({default: Proc.new { throw ActiveRecord::RecordNotFound.new } })
      expose(name) do
        parent_name = names.find {|n| params["#{n}_id"].present? }
        if parent_name.present?
          klass = parent_name.to_s.camelcase.constantize
          klass.find(params["#{parent_name}_id"])
        else
          instance_eval(&options[:default]) 
        end
      end
    end

  end
end
