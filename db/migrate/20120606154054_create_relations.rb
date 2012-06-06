class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :experiencie_id
      t.integer :proposal_id
      t.integer :user_id
      t.timestamps
    end

    add_index :relations, :experiencie_id
    add_index :relations, :proposal_id
    add_index :relations, :user_id
  end
end
