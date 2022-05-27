class Like < ApplicationRecord
    validates :user_id, uniqueness: {scope: [:likable_id, :likable_type]}
    belongs_to :user,
        primary_key: :id,
        foreign_key: :user_id,
        class_name: :User

    
    belongs_to :likable,
        polymorphic: true

end
