class Artist < ActiveRecord::Base
  has_many :songs
  has_many :albums,  -> { distinct }, through: :songs

  validates :name, presence: true
end
