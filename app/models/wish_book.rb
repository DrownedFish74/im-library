class WishBook < ApplicationRecord
  belongs_to :wish
  belongs_to :book
end
