module AgentsHelper
  def render_agent_info(agent)
    render partial: 'agents/info', locals: {agent: agent}
  end
end
