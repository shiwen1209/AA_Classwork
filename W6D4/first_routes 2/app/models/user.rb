# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  username   :string           not null
#
class User < ApplicationRecord
    validates :username, presence: true, uniqueness: true

    has_many :artworks,
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :Artwork,
        dependent: :destroy

    has_many :shares, 
        primary_key: :id,
        foreign_key: :viewer_id, 
        class_name: :ArtworkShare,
        dependent: :destroy

    has_many :shared_artworks,
        through: :shares,
        source: :artwork
      
    has_many :comments,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Comment,
        dependent: :destroy

    has_many :likes,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :Like,
        dependent: :destroy

    has_many :liked_comments,
        through: :likes, 
        source: :likable, 
        source_type: 'Comment'

    has_many :liked_artworks,
        through: :likes, 
        source: :likable, 
        source_type: "Artwork"



end
