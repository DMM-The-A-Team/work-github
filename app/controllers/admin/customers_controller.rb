class Admin::CustomersController < ApplicationController

  def index
   @customers = Customer.all
  end

  def show
   @customer = Customer.find(params[:id])
  end

  def edit
   @customer = Customer.find(params[:id])
  end

  def update
   @customer = Customer.find(params[:id])
   if @customer.update(customer_params)
    redirect_to admin_customers_index_path
   else
    render :edit
   end
  end


private

  def customer_params
  params.require(:customer).permit(:sunname, :name, :sunname_kana, :name_kana, :postal_code, :address, :telephone_number, :email, :is_deleted)
  end

end
