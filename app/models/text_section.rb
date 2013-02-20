class TextSection < Section
  attr_accessible :title, :body, :position

  validates :body, presence: true
  default_scope lambda { where(locale: T.l.to_s, id: nil).order('position ASC') }
end
