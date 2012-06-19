class Page < Content
  mount_uploader :image, PageImageUploader
  has_paper_trail

  validates_presence_of :body_type

  has_many :sections, as: :document, conditions: proc { ['lang = ?', I18n.locale] }

end
