module CommentsHelper
  def comments_link(document)
    count = document.comments.count
    link_to "#{icon(:comments)} #{count} #{Comment.model_name.human(count: count)} <i class='icon-chevron-down pull-right'></i>".html_safe, "#comments"
  end

  def link_to_comment(comment, text = Comment.model_name.human)
    link_to text, parent_url(comment.document) << "#comment_#{comment.id}"
  end

  def link_to_comment_parent(comment)
    link_to comment.document.title, parent_url(comment.document)
  end

  private

  def parent_url(document)
    if document.class == Category
      url_for [document.phase, document]
    else
      url_for document
    end
  end
end
