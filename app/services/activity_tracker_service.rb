class ActivityTrackerService
  def initialize(trackable, owner, action)
    @activity = PublicActivity::Activity.new
    @activity.trackable = trackable
    @activity.owner = owner
    @activity.key = set_activity_key(action)
    @activity.parameters = parameters
    @activity.recipient = recipient
  end

  def track
    @activity.save unless duplicated_activity?
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
    params = { locale: T.l.to_s }
    if @activity.key == :updatw
      params.merge changes: @activity.trackable.changes.to_hash
    else
      params.merge attributes: @activity.trackable.attributes.to_hash
    end
  end

  def recipient
    if @activity.trackable.class == Comment
      @activity.trackable.document
    end
  end

  def duplicated_activity?
    @activity.key.include?("update") &&
      PublicActivity::Activity.where(
        trackable_id: @activity.trackable_id,
        trackable_type: @activity.trackable_type,
        owner_id: @activity.owner_id,
        owner_type: @activity.owner_type
      ).where("created_at > ?", 1.hour.ago).exists?
  end
end

