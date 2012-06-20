class AddPositionToCategoriesAndProposals < ActiveRecord::Migration
  def change
    add_column :categories, :position, :integer
    add_column :proposals, :position, :integer

    Phase.all.each do |phase|
      phase.categories.each_with_index do |category, index|
        category.update_attribute(:position, index + 1)
        category.proposals.each_with_index do |p, i|
          p.update_attribute(:position, i +1)
        end
      end
    end
  end
end
