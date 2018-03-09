class AddReferenceHomeworkToUser < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :homework, foreign_key: true
  end
end
