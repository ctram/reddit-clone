class ChangeContentToText < ActiveRecord::Migration
  def change
    change_column :comments, :content, :text, null: false
  end
end
