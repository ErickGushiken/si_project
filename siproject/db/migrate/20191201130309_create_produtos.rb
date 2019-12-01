class CreateProdutos < ActiveRecord::Migration[5.2]
  def change
    create_table :produtos do |t|
      t.string :nome
      t.text :descricao
      t.decimal :valor, precision: 5, scale: 2
      t.string :categoria

      t.timestamps
    end
  end
end
