class Reply < ApplicationRecord
  belongs_to :post
  belongs_to :user
  paginates_per 10
end
