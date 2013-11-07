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
    searches_rows = self.class.global_search(fts_dictionary, @query).
      where(locale: T.l)
    prepare_results(searches_rows)
  end

  def self.primary_key
    'searchable_id'
  end

  def fts_dictionary
    @dictionary ||= case T.l
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

  private

  def prepare_results(searches_rows)
    searchables = searches_rows.preload(:searchable).map!(&:searchable).uniq.compact
    searchables.each do |searchable|
      searchable.title = highlight_result(searchable.title)
      add_excerpts(searchable)
    end
  end

  def add_excerpts(searchable)
    excerpts = []
    excerpts.push highlight_result(searchable.summary) if highlight_result?(searchable.summary)
    if searchable.respond_to?(:sections)
      searchable.sections.each do |section|
        excerpts.push highlight_result(section.title) if highlight_result?(section.title)
        excerpts.push highlight_result(section.body) if highlight_result?(section.body)
      end
    end
    searchable["excerpts"] = excerpts.join(' ||| ')
  end

  def highlight_result?(string)
    sql = "SELECT
             to_tsvector('#{fts_dictionary}', unaccent(#{sanitized_string(string)}))
           @@
             plainto_tsquery('#{fts_dictionary}', unaccent(#{sanitized_query})) AS true_or_false"

    query_result = ActiveRecord::Base.connection.execute(sql)
    ActiveRecord::ConnectionAdapters::Column.value_to_boolean(query_result.first["true_or_false"])
  end

  def highlight_result(string)
    sql = "SELECT
             ts_headline(
               '#{fts_dictionary}',
               unaccent(#{sanitized_string(string)}),
               plainto_tsquery('#{fts_dictionary}', unaccent(#{sanitized_query})),
               'FragmentDelimiter = \" ||| \", StartSel = \"<span class=ts-highlight>\", StopSel = </span>'
             )"
    ActiveRecord::Base.connection.execute(sql).first["ts_headline"]
  end

  def sanitized_query
    @sanitized_query ||= ActiveRecord::Base.sanitize(@query)
  end

  def sanitized_string(string)
    ActiveRecord::Base.sanitize(string)
  end
end

