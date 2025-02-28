class AddPropToPosts < ActiveRecord::Migration[7.2]
  def change
    add_column :posts, :title, :string
    add_column :posts, :body, :text
    add_column :posts, :summary, :string
    add_column :posts, :published, :boolean
  end
end
