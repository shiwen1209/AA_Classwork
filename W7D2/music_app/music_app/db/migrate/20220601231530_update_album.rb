class UpdateAlbum < ActiveRecord::Migration[5.2]
  def change
    add_column :albums, :title, :string, null: false 
    add_column :albums, :year, :integer, null: false
    add_column :albums, :band_id, :integer, null: false
    add_column :albums, :album_type, :string, null: false
  end
end
