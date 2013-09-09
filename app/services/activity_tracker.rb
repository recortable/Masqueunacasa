class ActivityTracker
  def initialize(trackable, owner, action)
    @activity = PublicActivity::Activity.new
    @activity.trackable = trackable
    @activity.owner = owner
    @activity.key = set_activity_key(action)
    @activity.parameters = parameters
    @activity.recipient = recipient
  end

  def track
    @activity.save
  end

  private

  def set_activity_key(action)
    action = :translate if new_translation?(action)
    "#{@activity.trackable.class.name.downcase}.#{action.to_s}"
  end

  def new_translation?(action)
    action == :update &&
      @activity.trackable.respond_to?('new_translation') &&
      @activity.trackable.new_translation == 'true'
  end

  def parameters
    { locale: T.l.to_s, attributes: @activity.trackable.changes }
  end

  def recipient
    if @activity.trackable.class == Comment
      @activity.trackable.document
    end
  end
end
