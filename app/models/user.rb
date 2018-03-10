class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :posts
  has_many :submissions
  has_many :replies
  has_many :images
  belongs_to :view
  has_attached_file :thumb
  validates_attachment :thumb, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
end
