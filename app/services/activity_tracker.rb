class ActivityTracker
  def initialize(trackable, owner, action)
    @trackable = trackable
    @owner = owner
    @new_translation = action == :update &&
      trackable.respond_to?('new_translation') &&
      trackable.new_translation == "true"
    @key = @new_translation ? :translate : action
  end

  def track
    @key = :translate if @new_translation
    if @key == :destroy
      track_destroy
    else
      @trackable.create_activity @key, owner: @owner, params: parameters
    end
  end

  private

  def parameters
    { locale: T.l.to_s, attributes: @trackable.attributes }
  end

  def track_destroy
    activity = PublicActivity::Activity.new
    activity.owner = @owner
    activity.assign_attributes({
      key: "#{@trackable.class.name.downcase}.destroy",
      trackable_id: @trackable.id,
      trackable_type: @trackable.class.name,
      parameters: parameters
    }, without_protection: true)
    activity.save
  end
end
