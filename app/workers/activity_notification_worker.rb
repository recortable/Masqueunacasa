class ActivityNotificationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely 1 }

  def perform
    users = User.where(id: 34)
    activities = PublicActivity::Activity.where(notified: false).
      order('created_at DESC')

    unless activities.empty?
      users.each do |user|
        ActivityNotificationMailer.email_for_admins(user, activities).deliver
      end
    end

    activities.update_all notified: true
  end
end

