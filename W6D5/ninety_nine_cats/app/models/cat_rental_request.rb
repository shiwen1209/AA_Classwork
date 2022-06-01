# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :bigint           not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CatRentalRequest < ApplicationRecord

    validates :cat_id, :start_date, :end_date, presence: true
    validates :status, inclusion: { in: %w(PENDING APPROVED DENIED)}



    belongs_to :cat,
    primary_key: :id,
    foreign_key: :cat_id,
    class_name: :Cat

    def overlapping_requests
        CatRentalRequest
        .select('*')
        .where('start_date BETWEEN ? AND ? ', start_date, end_date)
        .where(cat_id: cat_id)
        .where.not(id: id)
        .or(
        CatRentalRequest
        .select('*')
        .where('end_date BETWEEN ? AND ? ', start_date, end_date)
        .where(cat_id: cat_id)
        .where.not(id: id)
        )
        
        
    end
    # .where('end_date BETWEEN(?, ?)', start_date, end_date)
end
