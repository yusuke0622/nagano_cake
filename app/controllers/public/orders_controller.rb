class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def index
    @orders = current_customer.orders.all
  end
  
  def confirm
    @order = Order.new(order_params)
    @cart_items = current_customer.cart_items
    @order.customer_id = current_customer.id
    @total_price = @cart_items.sum{|cart_item|cart_item.item.add_tax_price * cart_item.amount}
    @order.postage = 800
    
    if params[:order][:destination_number] == "0"
      @order.postal_code = current_customer.postal_code
      @order.destination = current_customer.address
      @order.address_name = current_customer.first_name + current_customer.last_name
      render :confirm
    elsif params[:order][:destination_number] == "1"
      @order.postal_code = params[:order][:postal_code]
      @order.destination = params[:order][:destination]
      @order.address_name = params[:order][:address_name]
    else
      render :new
    end
  end
  
  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    if @order.save!
      @cart_items = current_customer.cart_items
      @cart_items.each do |cart_item|
        order_detail = OrderDetail.new(order_id: @order.id)
        order_detail.item_id = cart_item.item_id
        order_detail.amount = cart_item.amount
        order_detail.price = cart_item.item.price
        order_detail.save
      end
      redirect_to orders_thanx_path
      @cart_items.destroy_all
    else
      render :new
    end
  end
  
  def thanx
  end

  

  def show
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :destination, :address_name, :postage, :amount_billed)
  end
  
end
