class CreateHomeworks < ActiveRecord::Migration[5.0]
  def change
    create_table :homeworks do |t|
      t.string   :title
      t.string   :content
      t.datetime :closing

      t.timestamps
    end
  end
end
