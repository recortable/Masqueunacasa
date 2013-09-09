# Molaría cambiar el nombre a ActivityTrackerService
# o ActivityService para
# seguir una convención y para que funcione con Rails.vim
# (ver config/projections.json)
class ActivityTracker
  def initialize(trackable, owner, action)
    @activity = PublicActivity::Activity.new
    @activity.trackable = trackable
    @activity.owner = owner
    @activity.key = set_activity_key(action)
    @activity.parameters = parameters
  end

  def track
    @activity.save
  end

  private

  def set_activity_key(action)
    action = :translate if (action == :update && @activity.trackable.new_translation)
    "#{@activity.trackable.class.name.downcase}.#{action.to_s}"
  end

  def parameters
    { locale: T.l.to_s, attributes: @activity.trackable.changes }
  end
end
