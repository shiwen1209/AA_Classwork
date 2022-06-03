# == Schema Information
#
# Table name: albums
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  title      :string           not null
#  year       :integer          not null
#  band_id    :integer          not null
#  album_type :string           not null
#
class Album < ApplicationRecord
    validates :title, :year, :band_id, :album_type, presence: true
    validates :album_type, inclusion: { in: %w(live studio)}

    belongs_to :band,
        primary_key: :id,
        foreign_key: :band_id, 
        class_name: :Band,
        optional: false 
    
end
