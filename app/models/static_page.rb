require 'open-uri'

class StaticPage
  attr_accessor :url, :title
  def initialize(url)
    @url = url
    read_page
  end

  def content 
    @content ||= @body.to_html.gsub(/<\/?body>/,'')
  end

  protected
  def read_page
    page = Nokogiri::HTML(open(@url), 'utf-8')   
    @title = page.xpath("//title").text
    @body = page.xpath('//div[@id="contents"]')
    #page.xpath("//head").remove
    @body.xpath("//script").remove
    @body.xpath("//style").remove
    @body.xpath("//@style").remove
  end

end
