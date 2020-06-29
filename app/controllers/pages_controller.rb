#
class PagesController < ApplicationController
  def show
    @page = Page.find params[:id]
    set_meta_tags @page.metatags
  end

  def index
    @pages = Page.all
  end
end
