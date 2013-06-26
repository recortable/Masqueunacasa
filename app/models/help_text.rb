class HelpText < ActiveRecord::Base
  attr_accessible :identf, :description, :body, :blocked
  translates :body

  validates :identf, presence: true, format: { with: /\A\w+\z/ },
    length: { maximum: 30 }
  validates :description, length: { maximum: 300 }
  validates :body, presence: true
end
