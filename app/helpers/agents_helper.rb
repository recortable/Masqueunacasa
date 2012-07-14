module AgentsHelper
  def render_agent_info(agent)
    render partial: 'agents/info', locals: {agent: agent}
  end

  def render_agent_locations(agent)
    render partial: 'agents/locations', locals: { agent: agent }
  end
end
