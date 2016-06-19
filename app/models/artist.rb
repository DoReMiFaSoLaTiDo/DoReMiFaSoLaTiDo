class Artist < ActiveRecord::Base
  has_many :songs
  has_many :albums,  -> { distinct }, through: :songs

  validates :name, presence: true

  def image_url
    image ? image : request_image
  end

  private

    def request_image
      '/art/01-13264.jpg'
    end

end
