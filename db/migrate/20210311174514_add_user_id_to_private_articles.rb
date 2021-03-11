class AddUserIdToPrivateArticles < ActiveRecord::Migration[6.1]
  def change
    add_column :private_articles, :user_id, :int
  end
end
