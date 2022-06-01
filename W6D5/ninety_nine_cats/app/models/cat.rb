# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require "action_view"

class Cat < ApplicationRecord

    include ActionView::Helpers::DateHelper

    validates :birth_date, :name, :sex, presence: true
    validates :color, inclusion: { in: %w(black white orange brown multi_colored green), message: "%{value} is not valid"}
    validates :sex, inclusion: { in: %w(M F)}

    def age
        age = ((Date.today - birth_date) /365.25).to_i
        # time_ago_in_words(@birth_date)
    end

    has_many :rental_requests,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :CatRentalRequest,
    dependent: :destroy
end
