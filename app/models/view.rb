class View < ApplicationRecord
  belongs_to :post
  has_many :users
end
