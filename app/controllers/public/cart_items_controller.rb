class Public::CartItemsController < ApplicationController
  def index
    @cart_items = current_customer.cart_items
    @total_price = @cart_items.sum{|cart_item|cart_item.item.add_tax_price * cart_item.amount}
  end
  
  def create 
    @cart_item = current_customer.cart_items.new(cart_item_params)
    if current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.save
      redirect_to cart_items_path
    elsif @cart_item.save!
      redirect_to cart_items_path
    end
  end
  
  def update
    @cart_item = CartItem.find(params[:id])
    if params[:cart_item][:amount] == "0"
      @cart_item.destroy
      redirect_to cart_items_path
    else @cart_item.update(amount: params[:cart_item][:amount])
      redirect_to cart_items_path
    end
  end
  
  def destroy
    current_customer.cart_items.find(params[:id]).destroy
    redirect_to cart_items_path
  end
  
  def destroy_all
    current_customer.cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  private
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
