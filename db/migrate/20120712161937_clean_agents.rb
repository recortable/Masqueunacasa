class CleanAgents < ActiveRecord::Migration
  def change
    remove_column :agents, :subdomain
    add_column :agents, :summary_es, :string, limit: 500
    add_column :agents, :summary_ca, :string, limit: 500
    add_column :agents, :summary_en, :string, limit: 500
  end
end
