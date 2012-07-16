class RemoveStateFromMemberships < ActiveRecord::Migration
  def up
    Membership.all.each do |member|
      unless member.state == 'owner' || member.state == 'member'
        member.destroy
      end
    end
    remove_column :memberships, :state
  end

  def down
    add_column :memberships, :state, :string, limit: 16
    Membership.update_all(state: 'member')
  end
end
