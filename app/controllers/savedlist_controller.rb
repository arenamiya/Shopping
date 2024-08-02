class SavedlistController < ApplicationController

  def index
    list = JSON.parse(cookies[:savedlist])
    @saved = Collection.where(id: list)
  end

end
