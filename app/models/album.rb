class Album < ActiveRecord::Base
  belongs_to :publisher
  has_many :songs

  validates :name, presence: true, length: { in: 2..50 }
  validates :cover_art, presence: true
  validates :released_on, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format YYYY-MM-DD" }

  validates :publisher, presence: true

  @@datastore = Hash.new()

 scope :recent, -> (num_albums) { order(created_at: :desc).where("created_at > ?", 4.month.ago).limit(num_albums) }


  def self.most_recent
    mr = Album.order(created_at: :asc).reverse_order.limit(4).reverse
    set('most_recent',mr)
    mr
  end

  def self.set(key, value)
    @@datastore[key] = value
  end

  def self.get(key)
    @@datastore[key] ||= Album.most_recent
    
  end


end
