class AddUrlToBooks < ActiveRecord::Migration[7.2]
  def change
    add_column :books, :wiki_url, :string
  end
end
