class Post < ApplicationRecord
  belongs_to :user
  has_many :views, dependent: :destroy
  has_many :replies, dependent: :destroy
end
