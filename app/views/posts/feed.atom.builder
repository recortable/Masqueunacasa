atom_feed :language => I18n.locale do |feed|
  feed.title current_group.name + "::masqueunacasa.org"
  feed.updated posts.first.created_at unless posts.empty?
  posts.each do |post|
    feed.entry post do |entry|
      entry.title post.title
      summary = truncate_html(post.body, length: 500)
      entry.content "type" => "html" do entry.cdata!(summary) end
      entry.author do |author|
        author.name post.group.name
      end
    end
  end
end
