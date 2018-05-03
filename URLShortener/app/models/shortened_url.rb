# == Schema Information
#
# Table name: shortened_urls
#
#  id        :bigint(8)        not null, primary key
#  long_url  :string           not null
#  short_url :string           not null
#  user_id   :integer          not null
#

class ShortenedUrl < ApplicationRecord
  validates :long_url, :short_url, presence: true, uniqueness: true
  validates :user_id, presence: true

  has_many :visits,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: :Visit

  has_many :visitors,
  through: :visits,
  source: :user

  belongs_to :submitter,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  def self.generate_short(user, long_url)
    short_url = self.random_code
    ShortenedUrl.create!({long_url: long_url, short_url: short_url, user_id: user.id})
  end

  def self.random_code
    first_random = SecureRandom.urlsafe_base64

    until ShortenedUrl.exists?(first_random)
      first_random = SecureRandom.urlsafe_base64
    end
    first_random
  end


end
