class AddMoreInfoToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :updated_at, :datetime
    add_column :groups, :created_at, :datetime
    add_column :groups, :domain, :string, limit: 100
    add_column :groups, :subdomain, :string, limit: 100
    add_column :groups, :memberships_count, :integer, default: 0

    Group.all.each do |group|
      group.created_at = Time.utc(2012, 5, 1)
      group.memberships_count = group.users.count
      group.save
    end
  end
end
