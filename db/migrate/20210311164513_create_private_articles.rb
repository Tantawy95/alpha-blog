class CreatePrivateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :private_articles do |t|
      t.string :title
      t.text :description
      t.boolean :isprivate, default: true
      t.timestamps
    end
  end
end
