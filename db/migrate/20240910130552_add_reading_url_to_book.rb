class AddReadingUrlToBook < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :reading_url, :string
  end
end
