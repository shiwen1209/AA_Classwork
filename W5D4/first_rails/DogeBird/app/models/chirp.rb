# == Schema Information
#
# Table name: chirps
#
#  id         :bigint           not null, primary key
#  body       :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Chirp < ApplicationRecord
    # validates :author_id, :body, presence: true
    validates :body, presence: true  #it's implicit that author_id needs to be true in belong to, thurs we can remove
    validate :body_too_long
    def body_too_long
        if body && body.length > 140
            errors[:body] << 'too long'
        end 
    end

    #with author id 1 bring me the author with author id 1
    #we can call call Chirp.user
    belongs_to :user,
        primary_key: :id,
        foreign_key: :author_id,
        class_name: :User
        # optional: true # make it is ok to have null for author id

    has_many :likes,
        primary_key: :id,
        foreign_key: :chirp_id,
        class_name: :Like

    has_many :likers,
        through: :likes, 
        source: :user

end
