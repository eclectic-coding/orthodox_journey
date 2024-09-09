class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.string :author
      t.datetime :authored_at
      t.text :description
      t.boolean :reading, default: false
      t.boolean :completed, default: false

      t.timestamps
    end
  end
end
