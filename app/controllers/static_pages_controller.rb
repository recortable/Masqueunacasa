
class StaticPagesController < ApplicationController

  def show
    url = 'https://docs.google.com/document/pub?id=1wW6dCIgs3pXHfhtLeaELlVqn26jpLNImaUfxI3y7rQo'
    @page = StaticPage.new(url)
  end
end
