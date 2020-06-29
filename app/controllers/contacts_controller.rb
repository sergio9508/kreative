class ContactsController < ApplicationController

  def create
    @contact = Contact.new item_params

    return render json: { success: true }, status: :created if @contact.save
    render json: @contact.errors, status: :unprocessable_entity
  end

  def item_params
    params.require(:contact).permit(
      :name, :email, :phone, :content, :country_id
    )
  end

  def init_form
    @countries = Country.order :name
  end

end
