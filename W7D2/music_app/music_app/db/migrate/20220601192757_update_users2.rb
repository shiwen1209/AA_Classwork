class UpdateUsers2 < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :username
  end
end
