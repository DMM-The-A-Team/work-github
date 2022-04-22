class Public::CustomersController < ApplicationController

def show

end

def edit
  @customer = Customer.find(params[:id])
end

 private

 def public_params
 params.require(:customer).permit(:sunname, :name, :sunname_kana, :name_kana, :postal_code, :address, :telephone_number)
 end

end
