module SubscriptorsHelper
  def render_subscriptors_list(document)
    render partial: 'subscriptors/list', locals: { document: document }
  end
end
