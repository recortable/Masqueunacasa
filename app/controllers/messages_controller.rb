class MessagesController < ApplicationController
  respond_to :html
  before_filter :require_user

  expose(:messages) { current_group.messages }
  expose(:message)
  expose(:new_message) { Message.new }

  def index
    respond_with messages
  end

  def create
    message.group = current_group
    message.user = current_user
    if message.save
      flash[:notice] = 'notice.messages.created' 
      GroupMailer.message_email(message).deliver
    end
    respond_with message, location: messages_path
  end

  def destroy
    message.destroy
    respond_with message, location: messages_path
  end


end
