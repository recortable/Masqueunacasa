module ActionTracker
  def track_action(model, action = action_name.to_sym, db_action)
    tracker = ActivityTrackerService.new(model, current_user, action)
    if model.send(db_action)
      tracker.track
      true
    else
      false
    end
  end
end
