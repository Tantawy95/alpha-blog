class AddPrivateArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :articles, :private, :boolean, default: false 
  end
end
