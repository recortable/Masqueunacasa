class User < Agent
  def self.current_user
    nil
  end
end

class PopulateFriendlyIdSlugsTable < ActiveRecord::Migration
  def up
    ActiveRecord::Base.record_timestamps = false
    [Phase, Category, Proposal, Experiencie, Post].each do |klass|
      klass.all.each do |obj|
        obj.save
      end
    end
  end

  def down
  end
end
