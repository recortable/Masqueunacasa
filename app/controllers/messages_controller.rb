class MessagesController < ApplicationController
  respond_to :html

  expose(:messages) { Message.scoped }
  expose(:message)

  def show
    redirect_to message.resource
  end

  def create
    message.group_id = current_group.id
    message.user = current_user
    if message.save
      flash[:notice] = t('messages.notices.created') if message.save
    else
      flash[:notice] = message.errors.inspect
    end
    redirect_to message.resource
  end

  def destroy
    message.destroy
    respond_with message
  end


end
