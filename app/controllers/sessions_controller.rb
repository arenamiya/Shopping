class SessionsController < ApplicationController
  def create
    customer = Customer.find_by(email: params[:session][:email].downcase)
    if customer && customer.authenticate(params[:session][:password])
      log_in customer
      if session[:cart_id]
        cart = Cart.find(session[:cart_id])
        cart.update_attributes(user: current_customer.email)
        redirect_to carts_url
      else 
        redirect_back_or customer
      end
    else
      flash.now[:danger] = 'Wrong email or password!'
      render 'new'
    end
  end
  
  def new
  end
  
  def destroy 
    # Handling multiple sessions; only log
    # out in local
    log_out if logged_in?
    redirect_to root_url 
  end
  
end
