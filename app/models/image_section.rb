class ImageSection < Section
  validates :body, presence: true
  default_scope where(locale: T.l.to_s).order('position ASC')
end
