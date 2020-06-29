#
class HomeController < ApplicationController
  def index
    @pages = Page.all
    @service = ServiceCategory.enabled
    @projects = Portfolio.home
    @countries = Country.priority
    @brands = Brand.all
    @articles = Article.in_home.limit(2)
    @tecnologies = Tecnology.all
    
    @home = HomePage.first
  end
end
