class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :customer
    
    def add_tax_price
      (self.price * 1.10).floor
    end
    
    def subtotal
        item.add_tax_price.to_s(:delimited) * amount
    end
end
