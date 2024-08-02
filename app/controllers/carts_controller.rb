class CartsController < ApplicationController
  before_action :set_cart, only: %i[ show edit update ]
  before_action :logged_in_customer, only: [:index, :new]

  # GET /carts or /carts.json
  def index
    @carts = Cart.all.select_cart_by_user(current_customer.email)
    @products = []
    @total = 0
    @carts.each do |product|
       item = Collection.find(product.product_id)
       @products.push(item)
       @total += product.quantity * item.price
    end
  end

  # GET /carts/1 or /carts/1.json
  def show
  end

  # GET /carts/new
  def new
    @collection = Collection.find(params[:id]).id
    @login
    @sizes = ''
    @colors = ''
    @sizes = @collection.size.split(',') if @collection.size.present?
    @colors = @collection.colors.split(',') if @collection.colors.present?
  end

  # GET /carts/1/edit
  def edit
    @product = Collection.find(@cart.product_id)
  end

  # POST /carts or /carts.json
  def create
    @cart = Cart.new(cart_params)

    if logged_in?
      respond_to do |format|
        if @cart.save
          format.html { redirect_to '/carts', notice: "Item was successfully added to cart." }
          format.json { render :index, status: :created, location: @cart }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @cart.errors, status: :unprocessable_entity }
        end
      end

    else
      session[:cart_id] = @cart.id
      logged_in_customer
    end
  end

  # PATCH/PUT /carts/1 or /carts/1.json
  def update
    if cart_exists?
      @cart = saved_cart
      @cart.user = current_customer.email
      @cart.update_attributes(user: current_customer.email)
    end

    respond_to do |format|
      if @cart.update(cart_params)
        format.html { redirect_to @cart, notice: "Cart was successfully updated." }
        format.json { render :show, status: :ok, location: @cart }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @cart.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1 or /carts/1.json
  def destroy
    cart = Cart.where(:user => current_customer.email)
    cart.destroy_all unless cart.empty?
    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Thank you for purchasing!" }
      format.json { head :no_content }
    end
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cart
      @cart = Cart.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def cart_params
      params.require(:cart).permit(:user, :size, :color, :quantity, :product_id)
    end

    def logged_in_customer
      unless logged_in?
        store_location
        flash[:danger] = "Please log in first."
        redirect_to login_url, notice: "Please log in first."
      end
    end
end
