class Book < ApplicationRecord
  # relation
  has_many :shelves
  has_many :users, through: :shelves
end
