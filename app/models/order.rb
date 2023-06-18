class Order < ApplicationRecord
    belongs_to :customer
    has_many :order_details, dependent: :destroy
    has_many :items
    
    
    validates :destination, presence: true
    validates :postal_code, presence: true
    validates :address_name, presence: true
   
    enum payment_method: { credit_card: 0, transfer: 1 }
    
    def subtotal
        item.add_tax_price * amount
    end
end
