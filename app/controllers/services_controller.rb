class ServicesController < ApplicationController
  def index
    @categories = Service.all.order(priority: :asc)
    @services = ServiceCategory.all
  end
end
