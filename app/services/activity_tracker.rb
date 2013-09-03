class ActivityTracker
  def initialize(trackable, owner, action)
    @trackable = trackable
    @owner = owner
    @action = action
    @new_translation = action == :update &&
      trackable.respond_to?('new_translation') &&
      trackable.new_translation == "true"
  end

  def track
    action = :translate if @new_translation
    @trackable.create_activity action, owner: @owner, params: parameters
  end

  private

  def parameters
    { locale: T.l.to_s }
  end
end
