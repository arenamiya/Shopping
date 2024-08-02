class Collection < ApplicationRecord
    scope :filter_by_category, -> (category) { where("category LIKE ? ", "%" + "#{category}" + "%") }
    scope :filter_new_arrivals, -> (today) { where("stockdate > ?", 3.months.ago) }
    scope :filter_by_color, -> (color){ where("colors LIKE ? ", "%" + "#{color}" + "%") }
    scope :filter_by_size, -> (size){ where("size LIKE ? ", "%" + "#{size}" + "%") }
end
