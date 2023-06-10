class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @customer = current_customer
  end
  
  def confirm
    @order = Order.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.destination = current_customer.address
    @order.address_name = current_customer.first_name + current_customer.last_name
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.add_tax_price * cart_item.amount}
    @order.postage = 800
  end

  def index
  end

  def show
  end
  
  private
  def order_params
    params.require(:order).permit(:payment_method, :postal_code, :destination, :address_name)
  end
  
end
