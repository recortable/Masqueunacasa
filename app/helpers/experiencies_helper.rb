module ExperienciesHelper
  def render_experiencie_relations(experiencie)

    phase_proposals = {}
    phases = Phase.order('position ASC')
    phases.each do |phase|
      phase_proposals[phase.id] = []
    end

    proposals = experiencie.proposals
    proposals.each do |proposal|
      phase_proposals[proposal.phase_id] << proposal
    end
    
    
    render partial: 'experiencies/relations', locals: {experiencie: experiencie, phases: phases, phase_proposals: phase_proposals }
  end
end
