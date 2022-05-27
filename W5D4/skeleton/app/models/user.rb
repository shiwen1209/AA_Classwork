# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord

  #instructor?
    has_many :courses,
    primary_key: :id,
    foreign_key: :instructor_id,
    class_name: :Course

  #student
  has_many :enrollments,
  primary_key: :id,
  foreign_key: :student_id,
  class_name: :Enrollment

  
has_many :enrolled_courses,
through: :enrollments,
source: :course


end
