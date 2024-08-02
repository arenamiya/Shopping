module SessionsHelper
    def log_in(customer)
        session[:customer_id] = customer.id
    end
    
    def log_out
        forget(current_customer)
        session.delete(:customer_id) 
        @current_customer = nil 
    end
    
    def current_customer
        if (customer_id = session[:customer_id]) 
            @current_customer ||= Customer.find_by(id: customer_id) 
        elsif (customer_id = cookies.signed[:customer_id]) 
            customer = Customer.find_by(id: customer_id) 
            if customer && customer.authenticated?(cookies[:remember_token])
                log_in customer 
                @current_customer = customer 
            end
        end
    end
    
    def logged_in?
        !current_customer.nil?
    end
    
    def current_customer?(customer)
        customer == current_customer
    end
    
    # Connected to app/model/customers
    # (Both remember and forget)
    def remember(customer) 
        customer.remember 
        cookies.permanent.signed[:customer_id] = customer.id 
        # Duration is changeable in the expires: 
        cookies[:remember_token] = { value: remember_token, 
                                    expires: 20.years.from_now.utc }
    end
    
    def forget(customer)
        customer.forget
        cookies.delete(:customer_id)
        cookies.delete(:remember_token)
    end
    
    def redirect_back_or(default)
        redirect_to(session[:forwarding_url] || default)
        session.delete(:forwarding_url)
    end

    def store_location
        session[:forwarding_url] = request.url if request.get?
    end
end
