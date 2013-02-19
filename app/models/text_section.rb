class TextSection < Section
  attr_accessible :title, :body, :position

  validates :body, presence: true
  default_scope where(locale: T.l.to_s).order('position ASC')
end
