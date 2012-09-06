# encoding: UTF-8

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
    html = open(@url).read
    page = Nokogiri::HTML(html, nil, 'utf-8')
    page.encoding = 'utf-8'
    @title = page.xpath("//title").text
    @body = page.xpath('//div[@id="contents"]')
    #page.xpath("//head").remove
    @body.xpath("//script").remove
    @body.xpath("//style").remove
    @body.xpath("//@style").remove
  end

end
