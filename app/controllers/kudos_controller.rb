class KudosController < ApplicationController
  respond_to :html, :json

  expose_parent :document, [:phase, :category, :proposal, :experiencie, :post, :page]


  def update
    document.kudo(current_user || request.ip)
    respond_with document
  end
end
