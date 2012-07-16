module ProposalsHelper
  def render_proposal_list(category)
    render partial: 'proposals/list', locals: {category: category}
  end
end
