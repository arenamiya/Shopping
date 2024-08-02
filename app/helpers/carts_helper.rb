module CartsHelper

    def saved_cart
        if (cart_id = session[:cart_id]) 
            @saved_cart ||= Cart.find_by(id: cart_id) 
        elsif (cart_id = cookies.signed[:cart_id]) 
            cart = Cart.find_by(id: cart_id) 
            if cart && cart.authenticated?(cookies[:remember_token])
                @saved_cart = cart 
            end
        end
    end

    def cart_exists?
        !saved_cart.nil?
    end

    def saved_cart?(cart)
        cart == saved_cart
    end

    def forget(cart)
        cart.forget
        cookies.delete(:cart_id)
    end
end
