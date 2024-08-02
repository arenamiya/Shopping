json.extract! collection, :id, :name, :category, :price, :stockdate, :photo, :created_at, :updated_at
json.url collection_url(collection, format: :json)
