class CustomersController < ApplicationController
  def index
    @customers = Customer.all
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      redirect_to customers_path
    else
      render new_customer_path(@customer), status: 400
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :avatar, :gender, address_attributes: [:street, :city, :state, :country], phones_attributes: [:number])
  end
end
