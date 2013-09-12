class AddNotifiedToActivities < ActiveRecord::Migration
  def change
    add_column :activities, :notified, :boolean, default: false
  end
end
