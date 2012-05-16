class CreatePhases < ActiveRecord::Migration
  def change
    create_table :phases do |t|
      t.string :name_es, limit: 50
      t.string :name_ca, limit: 50
      t.text :description_es
      t.text :description_ca
      t.string :slug_es, limit: 50
      t.string :slug_ca, limit: 50
      t.integer :position
      t.timestamps
    end
    add_index :phases, :slug_es
    add_index :phases, :slug_ca
  end
end
