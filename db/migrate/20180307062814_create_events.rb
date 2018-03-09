class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string   :title
      t.datetime :start
      t.datetime :end
      t.string   :url
      t.text     :content

      t.timestamps
    end
  end
end
