module ReceiveMessages
  extend ActiveSupport::Concern

  included do
    has_many :received_messages, class_name: 'Message', as: :resource, order: 'created_at DESC'

  end

  def receive_message(message)
    message.resource = self
    message.save
  end
end
