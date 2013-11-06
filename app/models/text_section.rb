class TextSection < Section
  attr_accessible :title, :body, :position

  validates :body, presence: true
end

