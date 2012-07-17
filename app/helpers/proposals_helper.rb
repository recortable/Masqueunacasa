module ProposalsHelper
  def render_proposal_relations(proposal)
    render partial: 'proposals/relations', locals: {proposal: proposal}
  end

  def render_proposal_list(category)
    render partial: 'proposals/list', locals: {category: category}
  end
end
