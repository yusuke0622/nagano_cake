class CartItem < ApplicationRecord
    belongs_to :item
    belongs_to :customer
    
    has_one_attached :image
    
    validates :amount, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 1 }
    
    def add_tax_price
      (self.price * 1.10).floor
    end
    
    def subtotal
        item.add_tax_price * amount
    end

end
