class Image < ApplicationRecord
    scope :select_images_by_id, -> (id) { where(ID: id) }
end
