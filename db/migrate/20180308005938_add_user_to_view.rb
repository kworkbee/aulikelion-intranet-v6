class AddUserToView < ActiveRecord::Migration[5.0]
  def change
    add_reference :views, :user, foreign_key: true
  end
end
