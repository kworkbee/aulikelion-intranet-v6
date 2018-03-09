class AddFileToSubmission < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :file, :text
  end
end
