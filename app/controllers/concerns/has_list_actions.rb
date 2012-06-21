module HasListActions

  protected
  def move_up(resource)
    move_resource(resource, :move_higher)
  end

  def move_down(resource)
    move_resource(resource, :move_lower)
  end

  private
  def move_resource(resource, method)
    authorize! :update, resource
    resource.send(method)
    resource
  end
end
