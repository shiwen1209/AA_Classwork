# == Schema Information
#
# Table name: artworks
#
#  id         :bigint           not null, primary key
#  title      :string           not null
#  image_url  :string           not null
#  artist_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Artwork < ApplicationRecord
    validates :artist_id, :title, :image_url, presence: true
    validates :title, uniqueness: {scope: :artist_id,
        message: "Should only have the 1 of the same title per artist"}

    belongs_to :artist, 
        primary_key: :id,
        foreign_key: :artist_id,
        class_name: :User
        

    has_many :shares, 
        primary_key: :id,
        foreign_key: :artwork_id, 
        class_name: :ArtworkShare


    has_many :shared_viewers,
        through: :shares,
        source: :viewer

    has_many :comments,
        primary_key: :id,
        foreign_key: :artwork_id,
        class_name: :Comment,
        dependent: :destroy

    has_many :likes,
        as: :likable

end
