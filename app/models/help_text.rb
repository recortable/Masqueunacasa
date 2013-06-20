class HelpText < ActiveRecord::Base
  attr_accessible :identf, :description, :body
  translates :body

  validates :identf, presence: true, format: { with: /\A\w+\z/ },
    length: { maximum: 20 }
  validates :body, presence: true
end
