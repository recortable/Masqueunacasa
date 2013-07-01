module CommentsHelper
  def comments_link(document)
    count = document.comments.count
    link_to "#{icon(:comments)} #{count} #{Comment.model_name.human(count: count)} <i class='icon-chevron-down pull-right'></i>".html_safe, "#comments"
  end
end
