class Authorizations::Base

  def can?(action, model)
    a = abilities extract_resource(model)
    a.include?(:manage) || a.include?(action)
  end

  protected
  def can(action, resource)
    abilities(resource) << action
  end

  def extract_resource(model)
    if model.class == Class
      model
    elsif model.respond_to?(:first)
      model.first.class
    else
      model.class
    end
  end

  def abilities(resource)
    @rules ||= {}
    @rules[resource] ||= []
    @rules[resource]
  end
end
