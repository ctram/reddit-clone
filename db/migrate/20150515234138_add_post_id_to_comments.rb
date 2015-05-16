class AddPostIdToComments < ActiveRecord::Migration
  def change
    add_column :comments, :post_id, :integer, null: false, default: 0
  end
end
