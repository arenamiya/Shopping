class CollectionsController < ApplicationController
  before_action :set_collection, only: %i[ show edit update destroy ]

  # GET /collections or /collections.json
  def index
    @collections = Collection.all
    @title = "All"
    if params[:category].present?
      @collections = @collections.filter_by_category(params[:category])
      @title = params[:category]
    end
    if params[:stockdate].present?
      @collections = @collections.filter_new_arrivals(params[:stockdate])
      @title = "New Additions"
    end
    if params[:color].present?
      @collections = @collections.filter_by_color(params[:color])
      @title = params[:color]
    end
    if params[:size].present?
      @collections = @collections.filter_by_size(params[:size])
      @title = params[:size]
    end
  end

  # GET /collections/1 or /collections/1.json
  def show
    @images = Image.all
    @images = @images.select_images_by_id(params[:id]) if params[:id].present?
    @cart = Cart.new
    @sizes = ''
    @colors = ''
    @sizes = @collection.size.split(',') if @collection.size.present?
    @colors = @collection.colors.split(',') if @collection.colors.present?
  end

  # GET /collections/new
  def new
    @collection = Collection.new
  end

  # GET /collections/1/edit
  def edit
  end

  # POST /collections or /collections.json
  def create
    @collection = Collection.new(collection_params)

    respond_to do |format|
      if @collection.save
        format.html { redirect_to @collection, notice: "Collection was successfully created." }
        format.json { render :show, status: :created, location: @collection }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /collections/1 or /collections/1.json
  def update
    respond_to do |format|
      if @collection.update(collection_params)
        format.html { redirect_to @collection, notice: "Collection was successfully updated." }
        format.json { render :show, status: :ok, location: @collection }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @collection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /collections/1 or /collections/1.json
  def destroy
    @collection.destroy
    respond_to do |format|
      format.html { redirect_to collections_url, notice: "Collection was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_collection
      @collection = Collection.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def collection_params
      params.require(:collection).permit(:name, :category, :price, :stockdate, :photo, :details, :colors, :size)
    end

end
