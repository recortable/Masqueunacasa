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
      send_message(message)       
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

  private

  def send_message(message)
    GroupMailer.message_to_group(message).deliver if message.resource_type == "Group"
    GroupMailer.message_to_user(message).deliver if message.resource_type == "User" 
  end
end
