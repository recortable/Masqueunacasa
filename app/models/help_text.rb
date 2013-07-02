class HelpText < ActiveRecord::Base
  attr_accessible :identf, :description, :body, :blocked
  translates :body

  include HasTranslations

  validates :identf, presence: true, format: { with: /\A\w+\z/ },
    length: { maximum: 30 }
  validates :description, length: { maximum: 300 }
  validates :body_es, presence: true

  T.avl.each do |l|
    attr_accessible :"body_#{l.to_s}"

    define_method "body_#{l.to_s}" do
      T.w_l(l) { body if translated_to?(l) }
    end

    define_method "body_#{l.to_s}=" do |value|
      T.w_l(l) { self.body = value if value.present? }
    end
  end
end
