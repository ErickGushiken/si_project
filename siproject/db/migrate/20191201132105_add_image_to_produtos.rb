class AddImageToProdutos < ActiveRecord::Migration[5.2]
  def change
    add_column :produtos, :image, :string
  end
end
