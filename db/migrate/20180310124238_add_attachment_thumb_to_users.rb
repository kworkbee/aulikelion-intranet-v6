class AddAttachmentThumbToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :thumb
    end
  end

  def self.down
    remove_attachment :users, :thumb
  end
end
