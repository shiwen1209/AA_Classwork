# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  long_link  :string           not null
#  short_link :string           not null
#  user_id    :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
  validates :long_link, :short_link, presence: true, uniqueness: true
  validates :user_id, presence: true 
  

  def self.random_code
    li = SecureRandom.urlsafe_base64
    until !ShortenedUrl.exists?(:short_link => li) #until ShortenedUrl.exists?(:short_link => li) == false
    li = SecureRandom.urlsafe_base64
    end    
    return li
  end

def self.factory_create(user, long_url)
    short_url = ShortenedUrl.random_code
    short = ShortenedUrl.create!(long_link: long_url, short_link: short_url, user_id: user.id)
    short
end

def num_clicks
  self.visits.length
end

def num_uniques
  # self.visitors.select(:email).distinct.length
  self.visitors.length
end

def num_recent_uniques
  end_date = DateTime.now - 10.minutes
  self.visits.where("created_at > ?", end_date).select(:user_id).distinct.length
  
end

belongs_to :submitter,
primary_key: :id,
foreign_key: :user_id,
class_name: :User

has_many :visits,
primary_key: :id, 
foreign_key: :short_url_id,
class_name: :Visit

has_many :visitors,
  Proc.new { distinct }, #<<<
  through: :visits,
  source: :visitor

end
