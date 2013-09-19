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
      flash[:notice] = t 'comments.notices.created'
    end
    respond_with comment, location: polymorphic_url(document, anchor: 'comments')
  end

  def edit
    authorize! :update, comment
    respond_with comment
  end

  def update
    authorize! :update, comment
    flash[:notice] = t('comments.notices.updated') if comment.save
    respond_with comment, location: polymorphic_url(document, anchor: 'comments')
  end

  def destroy
    authorize! :destroy, comment
    flash[:notice] = t('comments.notices.destroyed') if track_action(comment, :destroy)
    respond_with comment, location: polymorphic_url(document, anchor: 'comments')
  end
end

