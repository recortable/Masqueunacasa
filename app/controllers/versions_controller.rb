class VersionsController < ApplicationController
  respond_to :html
  expose(:versions) { current_group.versions.limit(50) }

  def index
    respond_with versions
  end
end
