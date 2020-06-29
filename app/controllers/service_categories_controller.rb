class ServiceCategoriesController < ApplicationController
  
  def show
    @service = ServiceCategory.find params[:id]
    @Category = ServiceCategory.created.order_service_at(ServiceCategory.find params[:id])
    set_meta_tags @service.metatags
  end

end
