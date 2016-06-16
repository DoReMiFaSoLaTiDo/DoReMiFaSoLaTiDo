class Album < ActiveRecord::Base
  belongs_to :publisher
  has_many :songs

  validates :name, presence: true, length: { in: 2..50 }
  validates :cover_art, presence: true
  validates :released_on, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format YYYY-MM-DD" }

  def self.recent(n)
    where("Album.created_at < ?", 4.months.ago ).limit(n)
  end

end
