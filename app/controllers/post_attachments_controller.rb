class PostAttachmentsController < ApplicationController
  respond_to :html

  expose(:post) { current_group.posts.find params[:post_id] }
  expose(:post_attachments) { post.attachments }
  expose(:post_attachment) 

  def new
    authorize! :create, PostAttachment
    respond_with post_attachment
  end

  def create
    post_attachment.post = post
    post_attachment.user = current_user
    post_attachment.group = current_group
    authorize! :create, post_attachment
    flash[:notice] = t('post_attachments.notices.created') if post_attachment.save
    respond_with post_attachment, location: post
  end

  def destroy
    authorize! :destroy, post_attachment
    flash[:notice] = t('post_attachments.notices.destroyed') if post_attachment.destroy
    respond_with post_attachment, location: post
  end

end
