class Post < ApplicationRecord
  belongs_to :user
  has_many :views
  has_many :replies
end
