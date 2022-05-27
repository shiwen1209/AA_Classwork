class CreateShortenedUrls < ActiveRecord::Migration[6.1]
  def change
    create_table :shortened_urls do |t|
      t.string :long_link,  null: false, unique: true
      t.string :short_link, null: false, unique: true
      t.integer :user_id, null: false
      t.timestamps
    end
  end
end
