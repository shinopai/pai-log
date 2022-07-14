class CreateBooks < ActiveRecord::Migration[7.0]
  def change
    create_table :books do |t|
      t.string :book_id, null: false
      t.string :title, null: false
      t.string :author, null: false
      t.text :description, null: false
      t.string :publisher, null: false
      t.date :publish_date, null: false
      t.string :image, null: false

      t.timestamps
    end
  end
end
