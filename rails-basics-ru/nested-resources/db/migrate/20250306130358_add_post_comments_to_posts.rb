class AddPostCommentsToPosts < ActiveRecord::Migration[7.2]
  def change
    add_reference :posts, :post_comments, null: true, foreign_key: true
  end
end
