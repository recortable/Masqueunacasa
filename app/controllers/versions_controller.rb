class VersionsController < ApplicationController
  respond_to :html
  expose(:versions) { Version.limit(50) }

  def index
    respond_with versions
  end
end
