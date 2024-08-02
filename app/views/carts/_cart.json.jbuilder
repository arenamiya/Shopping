json.extract! cart, :id, :user, :size, :color, :quantity, :created_at, :updated_at, :product_id
json.url cart_url(cart, format: :json)
