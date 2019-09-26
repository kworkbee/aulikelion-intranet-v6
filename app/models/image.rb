class Image < ApplicationRecord
    belongs_to :user
    has_attached_file :file, dependent: :destroy
    validates_attachment :file, content_type: { content_type: ["image/jpeg", "image/gif", "image/png"] }
    paginates_per 10
end
