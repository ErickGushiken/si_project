class ChangeDataNasc < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :data_nasc, :datetime
  end
end
