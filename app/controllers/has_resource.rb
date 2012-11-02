module HasResource
  def self.included(base)
    base.extend ClassMethods
  end

  module ClassMethods
    def expose_resource(name, options = {})
      options.reverse_merge! actions: []
      options[:actions] = [:index, :show, :new, :edit, :create, :update, :destroy] if options[:actions] == :all

      @resource_name = name.to_s
      include BangMethods

      options[:actions].each do |action|
        define_method(action) do
          self.send("#{action}!")
        end
      end
    end

    def resource_name
      @resource_name
    end
  end

  def resource_name
    self.class.resource_name
  end

  def resource_class
    resource_name.capitalize.constantize
  end

  def resource
    @resource ||= self.send(resource_name)
  end

  def collection
    @collection ||= self.send(resource_name.pluralize)
  end

  module BangMethods
    protected
    def index!
      authorize! :read, resource_class
    end

    def show!
      authorize! :read, resource
      respond_with resource
    end

    def new!
      authorize! :create, resource
      respond_with resource
    end

    def edit!
      authorize! :update, resource
      respond_with resource
    end

    def create!(&block)
      modify_resource(:create, &block)
    end

    def update!(&block)
      modify_resource(:update, &block)
    end

    def destroy!(&block)
      modify_resource(:destroy, &block)
    end

    def flash_for(action)
      flash[:notice] = t("#{resource_name}s.#{action}", 
                         default: t("resource.#{action}d"))
    end

    private
    def modify_resource(action, &block)
      authorize! action, resource
      if action == :destroy
        flash_for('destroyed') if resource.destroy
      else
        #resource.attributes = permitted_params.send(name)
        flash_for("#{action}d") if resource.save
      end
      url = block_given? ? yield : url_for(resource)
      respond_with resource, location: url
    end

  end
end
