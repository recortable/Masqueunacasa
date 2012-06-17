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
      flash[:notice] = t('messages.notices.created')
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
    if message.resource_type == "Group"
      recipients = message.group.recipients(scope = 'members')
      recipients.each do |user|
        GroupMailer.message_to_group(message, user.email).deliver 
      end
    end
        
    GroupMailer.message_to_user(message).deliver if message.resource_type == "User" 
  end
end
