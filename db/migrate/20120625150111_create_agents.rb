class CreateAgents < ActiveRecord::Migration
  def change
    rename_column :users, :name, :title
    rename_column :groups, :name, :title

    create_table :agents, as_relation_superclass: true do |t|
      t.string :name, limit: 50
      t.string :slug, limit: 50
      t.integer :kudos_count, default: 0
      t.integer :view_count, default: 0
      t.timestamps
    end
    add_index :agents, :slug

    create_agents
  end

  def create_agents
    User.all.each do |user|
      Agent.create!(as_agent_type: 'User', as_agent_id: user.id,
                    name: user.title)
    end

    Group.all.each do |group|
      Agent.create!(as_agent_type: 'Group', as_agent_id: group.id,
                    name: group.title)
    end

  end
end
