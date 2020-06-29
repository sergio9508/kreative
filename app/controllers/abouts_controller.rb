class AboutsController < ApplicationController
  def index
    @employees = Employee.all
    @brands = Brand.all
  end
end
