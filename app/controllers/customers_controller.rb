class CustomersController < ApplicationController

  before_action :logged_in_customer, only: [:edit, :update]
  before_action :correct_customer,   only: [:edit, :update]
  
  def create
    @customer = Customer.new(customer_params)
    
    if @customer.save
      log_in @customer
      redirect_to @customer
    else
      render 'new'
    end
  end
  
  def show
    @customer = Customer.find(params[:id])
  end

  def new
    @customer = Customer.new
  end

  def edit
    @customer = Customer.find(params[:id])
  end
  
  def index
  end


  def update
    @customer = Customer.find(params[:id])
    if @customer.update_attributes(customer_params)
      flash[:success] = "Profile updated!"
      redirect_to @customer
    else
      render 'edit'
    end
  end
 
 
  private
  def customer_params
    params.require(:customer).permit(:username, :email, :password, 
                    :password_confirmation)
  end


  def logged_in_customer
    unless logged_in?
      store_location
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end
  
  def correct_customer
    @customer = Customer.find(params[:id])
    redirect_to(root_url) unless current_customer?(@customer)
  end
  
  
end
