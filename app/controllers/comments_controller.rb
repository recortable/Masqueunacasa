class CommentsController < ApplicationController
  include ActionTracker

  respond_to :html

  expose_parent :document, [:proposal, :category, :experiencie]
  expose(:comments) { document.comments }
  expose(:comment)

  def create
    authorize! :create, Comment
    comment.user = current_user
    if track_action(comment, :save)
      flash[:notice] = "Comentario creado, gracias!"
    end
    respond_with comment, location: polymorphic_url(document, anchor: 'comments')
  end

  def edit
    authorize! :update, comment
    polymorphic_breadcrumb_for document
    respond_with comment
  end

  def update
    authorize! :update, comment
    flash[:notice] = "Comentario editado, gracias!" if comment.save
    respond_with comment, location: polymorphic_url(document, anchor: 'comments')
  end

  def destroy
    authorize! :destroy, comment
    flash[:notice] = "Comentario borrado, gracias!" if comment.destroy
    respond_with comment, location: polymorphic_url(document, anchor: 'comments')
  end
end
