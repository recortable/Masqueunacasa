class AgentsController < ApplicationController
  respond_to :html

  expose(:agents) { Agent.all }
  expose(:agent) 

  def index
    authorize! :read, Agent
  end
end
