class EditionsController < ApplicationController
  respond_to :html, :js
  expose_parent :document, [:category, :proposal, :experiencie, :post, :page]
  expose(:versions) { Activities.document_activity(document, limit: 10) }

  def show
    respond_with document
  end

end
