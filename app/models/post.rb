class Post < ApplicationRecord
  belongs_to :user
  has_many :views, dependent: :destroy
  has_many :replies, dependent: :destroy
  paginates_per 10
end
