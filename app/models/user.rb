class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :chatrooms, dependent: :destroy
  has_many :messages, dependent: :destroy
  belongs_to :view
  has_attached_file :thumb
  validates_attachment :thumb, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }

  def only_name
    email.split('@')[0]
  end
end