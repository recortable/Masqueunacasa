class Link < ActiveRecord::Base
  attr_accessible :title, :url
  delegate :title, to: :document, prefix: true

  belongs_to :user
  belongs_to :document, polymorphic: true

  validates :title, presence: true
  validates :url, presence: true
  validates :document, presence: true
  validates :user, presence: true
  #validates :content_type, presence: true

  before_validation :complete_title
  before_validation :set_content_type

  has_paper_trail meta: { 
    title: :title, 
    parent_title: :document_title, 
    document: :document
  }

  private
  def complete_title
    self.title ||= self.url
  end

  def set_content_type
    if self.url =~ /youtube/ 
      self.content_type = 'video'
    else
      self.content_type = 'link'
    end
  end
end
