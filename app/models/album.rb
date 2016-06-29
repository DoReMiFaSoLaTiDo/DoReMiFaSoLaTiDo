class Album < ActiveRecord::Base
  belongs_to :publisher
  has_many :songs

  validates :name, presence: true, length: { in: 2..50 }
  validates :cover_art, presence: true
  validates :released_on, presence: true, format: { with: /\A\d{4}-\d{2}-\d{2}\z/, message: "should be in the format YYYY-MM-DD" }

  validates :publisher, presence: true

  @@datastore = Hash.new()
  @@datastore[:most_recent] = []

 scope :recent, -> (num_albums) { order(released_on: :desc).where("released_on > ?", 4.month.ago).limit(num_albums) }


  def self.most_recent(num_albums=4)
    order(released_on: :asc).reverse_order.limit(num_albums).reverse
  end

  def self.consider_add(key, value)
    old_store = Album.get(key)
    #raise old_store.inspect
    # determine if album is already in collection. If it is, swap it with new, else add it
    old_store.to_a.each_with_index do |album, ind|
      if value.id == album.id
        old_store.delete_at(ind)
        old_store.push(value)
        break
      else

      end
    end

    old_store.to_a.push(value) unless old_store.to_a.include?(value)

    # raise old_store.size.inspect
    # remove old record that no longer belongs in collection
    if old_store.to_a.size > 4
      old_store = old_store.to_a.sort_by { |k| k[:released_on] } #&:released_on
      old_store.to_a.pop
    else
    end

    # save the new collection
    Album.set(:most_recent, old_store )

  end

  def self.get(key)
    @@datastore[key] ||= Album.most_recent
  end

  private

    def self.set(key, value)
      @@datastore[key] = value
    end

end
