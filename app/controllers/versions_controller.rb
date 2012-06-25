class VersionsController < ApplicationController
  respond_to :html
  expose(:versions) { Version.limit(50).order('created_at DESC') }

  def index
    respond_with versions
  end
end
