class Public::CustomersController < ApplicationController

def show
 @customer = current_customer
end

def edit
 @customer = current_customer
end

 private

 def public_params
 params.require(:customer).permit(:sunname, :name, :sunname_kana, :name_kana, :postal_code, :address, :telephone_number, :email)
 end

end
