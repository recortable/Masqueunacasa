class Search
  attr_reader :term
  attr_reader :errors, :results
  attr_reader :proposals

  def initialize(params)
    @results = []
    @errors = []
    @term = params[:t]
    perform_search if valid?
  end

  def perform_search
    match = "%#{@term}%"
    @proposals = Proposal.joins(:sections).where('body LIKE ?', match)

    @sections = Section.where('body LIKE ?', match)
    @results = @proposals.all
  end

  def valid?
    @errors << :term_to_short if @term.length < 3
    @errors.size == 0
  end
end
