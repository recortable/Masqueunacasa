class User < ActiveRecord::Base
  def self.current_user
    nil
  end
end

class PopulateFriendlyIdSlugsTable < ActiveRecord::Migration
  def up
    ActiveRecord::Base.record_timestamps = false
    [Phase, Category, Proposal, Experiencie, User].each do |klass|
      klass.all.each do |obj|
        obj.save
      end
    end

    ActiveRecord::Base.record_timestamps = true
  end

  def down
  end
end
