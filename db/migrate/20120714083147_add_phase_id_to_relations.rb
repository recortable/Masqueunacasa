class AddPhaseIdToRelations < ActiveRecord::Migration
  def change
    add_column :relations, :phase_id, :integer
    add_column :relations, :category_id, :integer

    Relation.all.each do |relation|
      relation.save
    end
  end
end
