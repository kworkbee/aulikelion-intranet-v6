class AddAttachmentFileToSubmissions < ActiveRecord::Migration
  def self.up
    change_table :submissions do |t|
      t.attachment :file
    end
  end

  def self.down
    remove_attachment :submissions, :file
  end
end
