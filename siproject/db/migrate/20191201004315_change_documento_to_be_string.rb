class ChangeDocumentoToBeString < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :documento, :string
  end
end
