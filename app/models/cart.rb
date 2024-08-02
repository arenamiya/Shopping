class Cart < ApplicationRecord
    validates :color, presence: true
    validates :size, presence: true
    validates :product_id, presence: true
    # validates :user, presence: true
    validates :quantity, presence: trust
    scope :select_cart_by_user, -> (user) { where(user: user) }
end
