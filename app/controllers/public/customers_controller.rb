class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end
  
  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "You have updated user info successfully."
      redirect_to my_page_path
    else
      render :edit
    end
  end
  
  def quit
    @customer = current_customer
  end
  
  def withdraw
    @customer = Customer.find(current_customer.id)
    @customer.update(is_deleted: true)
    reset_session
    flash[:notice] = "I have withdrawn from the membership."
    redirect_to root_path
  end
  
  private
    def customer_params
      params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana,
                                        :postal_code, :address, :telephone_number, :email)
    end
    
end
