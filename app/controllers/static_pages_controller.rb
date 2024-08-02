class StaticPagesController < ApplicationController
  def test
  end

  def checkout
    @carts.destroy_all
    respond_to do |format|
      format.html { redirect_to carts_url, notice: "Thank you for purchasing!" }
      format.json { head :no_content }
    end
  end
end
