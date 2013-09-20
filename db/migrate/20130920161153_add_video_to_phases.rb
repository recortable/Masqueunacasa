class AddVideoToPhases < ActiveRecord::Migration
  def change
    add_column :phases, :video, :string
  end
end
