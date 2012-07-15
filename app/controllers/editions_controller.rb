class EditionsController < ApplicationController
  expose_parent :document, [:categorie, :proposal, :experiencie]

  def show

  end
end
