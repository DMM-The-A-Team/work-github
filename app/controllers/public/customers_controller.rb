class Public::CustomersController < ApplicationController

def show
 @customer = current_customer
end

def edit
 @customer = current_customer
end

def update
 @customer = current_customer
 if @customer.update(customer_params)
  redirect_to customers_my_page_path
 else
 render :edit
 end
end


 
 private

 def customer_params
 params.require(:customer).permit(:sunname, :name, :sunname_kana, :name_kana, :postal_code, :address, :telephone_number, :email)
 end

end
