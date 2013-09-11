class ActivityNotificationWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { minutely 1 }

  def perform
    users = User.where(id: 34)

    users.each do |user|
      ActivityNotificationMailer.activity_email(user).deliver
    end
  end
end
