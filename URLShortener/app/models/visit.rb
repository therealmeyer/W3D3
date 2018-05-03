class Visit < ApplicationRecord

  validates :user_id, :short_url_id, presence: true

  belongs_to :user,
  primary_key: :id,
  foreign_key: :user_id,
  class_name: :User

  belongs_to :short_url,
  primary_key: :id,
  foreign_key: :short_url_id,
  class_name: :ShortenedUrl

    def self.record_visit!(user, shortened_url)
      Visit.create!({user_id: user.id, short_url_id: shortened_url.id})

    end

end
