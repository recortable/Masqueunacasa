class CommentsController < ApplicationController
  respond_to :html

  expose_parent :document, [:proposal, :category, :experiencie]
  expose(:comments) { document.comments }
  expose(:comment)

  def create
    authorize! :create, Comment
    comment.user = current_user
    flash[:notice] = "Comentario creado, gracias!" if comment.save
    respond_with comment, location: document
  end
end
