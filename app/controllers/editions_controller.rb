class EditionsController < ApplicationController
  expose_parent :document, [:category, :proposal, :experiencie]

  def show

  end
end
