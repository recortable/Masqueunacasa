class ActivityTracker
  def initialize(trackable, owner, action)
    @trackable = trackable
    @owner = owner
    @new_translation = action == :update &&
      trackable.respond_to?('new_translation') &&
      trackable.new_translation == "true"
    @key = key(action)
  end

  def track
    @key = :translate if @new_translation
    @trackable.create_activity @key, owner: @owner, params: parameters
  end

  private

  def key(action)
    if @new_translation
      :translate
    else
      action
    end
  end

  def parameters
    { locale: T.l.to_s }
  end
end
