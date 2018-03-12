class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :trackable, :validatable
  has_many :posts, dependent: :destroy
  has_many :submissions, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_many :images, dependent: :destroy
  has_many :logs, dependent: :destroy
  belongs_to :view
  has_attached_file :thumb
  validates_attachment :thumb, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
  validates :email, format: { with: /\b[A-Z0-9._%a-z\-]+@likelion\.org\z/, message: "멋사 이메일 계정으로만 가입가능" }
end