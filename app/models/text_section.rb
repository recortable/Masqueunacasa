class TextSection < Section
  attr_accessible :title, :body, :position

  validates :body, presence: true
  default_scope where('1 = 2')
end
