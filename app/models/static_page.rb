# encoding: UTF-8

require 'open-uri'

module StaticPages
  mattr_accessor :pages
  @@pages = {}

  mattr_accessor :url_base
  @@url_base = 'https://docs.google.com/document/'

  def self.add(slug, url)
    self.pages[slug] = url
  end

  def self.find(slug)
    page = self.pages[slug]
    raise ActiveRecord::RecordNotFound.new("StaticPage with slug #{slug} not found.") if page.blank?
    page
  end
end

class StaticPage
  attr_accessor :url, :title, :styles
  def initialize(id)
    @url = "#{StaticPages.url_base}#{id}"
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
    @styles = @body.xpath("//style")
    @body.xpath("//style").remove
    @body.xpath("//@style").remove
    @body.xpath("//img").each do |img|
      img['src'] = "#{StaticPages.url_base}#{img['src']}" if img['src'].present? 
    end
  end
end
