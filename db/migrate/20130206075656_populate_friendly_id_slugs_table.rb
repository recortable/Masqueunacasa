class PopulateFriendlyIdSlugsTable < ActiveRecord::Migration
  def up
    [Phase, Category, Proposal, Experiencie, Post].each do |klass|
      klass.all.each do |obj|
        obj.save
      end
    end
  end

  def down
  end
end
