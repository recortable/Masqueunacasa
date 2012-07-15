class SubscribersController < ApplicationController
  respond_to :html

  expose_parent :document, [:proposal]
  expose(:subscribers) { document.subscribers }
  expose(:subscriber)

  def create
    subscriber.user_id = params[:u]
    subscriber.save
    respond_with subscriber, location: document
  end

  def destroy
    subscriber.destroy
    respond_with subscriber, location: document
  end
end
