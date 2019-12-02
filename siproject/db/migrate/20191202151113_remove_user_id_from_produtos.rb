class RemoveUserIdFromProdutos < ActiveRecord::Migration[5.2]
  def change
    remove_column :produtos, :user_id, :integer
  end
end
