class Submission < ApplicationRecord
  belongs_to :user
  belongs_to :homework
  has_attached_file :file
  validates_attachment :file, content_type: { content_type: ["application/zip", "application/octet-stream", "application/x-gzip"] }
end
