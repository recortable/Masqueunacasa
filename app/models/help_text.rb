class HelpText < ActiveRecord::Base
  attr_accessible :identf, :description, :body, :blocked
  translates :body

  include HasTranslations

  validates :identf, presence: true, format: { with: /\A\w+\z/ },
    length: { maximum: 30 }
  validates :description, length: { maximum: 300 }
  validates :"body_#{T.dfl}", presence: true

  after_find :set_translated_bodies

  T.avl.each do |l|
    attr_reader :"body_#{l.to_s}"
    attr_accessible :"body_#{l.to_s}"

    define_method "body_#{l.to_s}=" do |value|
      T.w_l(l) { self.body = value if value.present? }
      instance_variable_set "@body_#{l}", value
    end
  end

  private

  def set_translated_bodies
    T.avl.each do |l|
      instance_variable_set "@body_#{l}", translated_to?(l) ? T.w_l(l) { body } : nil
    end
  end
end
