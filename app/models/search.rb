class Search < ActiveRecord::Base
  include PgSearch

  attr_accessible :query
  attr_accessor :query

  pg_search_scope :global_search, lambda { |dictionary, query|
    raise ArgumentError if dictionary.blank?
    return {
      against: {
        title: 'A',
        section_title: 'B',
        text: 'C'
      }, using: {tsearch: {dictionary: dictionary}},
      ignoring: :accents,
      query: query
    }
  }

  belongs_to :searchable, polymorphic: true

  def results
    self.class.global_search(Search.fts_dictionary(T.l), @query).
      where(locale: T.l).preload(:searchable).map!(&:searchable).uniq
  end

  def self.primary_key
    'searchable_id'
  end

  def self.fts_dictionary(locale)
    case locale.to_sym
    when :es
      'spanish'
    when :en
      'english'
    when :fr
      'french'
    when :it
      'italian'
    else
      'simple'
    end
  end
end

