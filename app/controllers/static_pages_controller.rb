
class StaticPagesController < ApplicationController

  StaticPages.add 'faq', 'pub?id=1wW6dCIgs3pXHfhtLeaELlVqn26jpLNImaUfxI3y7rQo'
  StaticPages.add('creditos', 'pub?id=16elj1tsdvLnPXQbCxsjgx6aOHmxk6gKk_ma6ionpdvE')

  def show
    url = StaticPages.find(params[:id])
    @page = StaticPage.new(url)
  end
end
