require 'test_helper'

class AlbumTest < ActiveSupport::TestCase
  setup do
    @album = albums(:one)
    @album2 = albums(:two)
    @album3 = albums(:three)
    @album4 = albums(:four)
    @album5 = albums(:five)
  end

  test "should not save album without publisher" do
    @album.publisher = nil
    assert_not @album.save, "Saved album without a publisher"
  end

  test "should return maximum of n albums released in last 4 months" do
    @album.save
    @album2.save
    @album3.save
    recent_albums = Album.recent(3)
    assert_includes(recent_albums, @album3)
  end

  test "should not return albums not released in last 4 months" do
    @album.save
    @album2.save
    @album3.save
    recent_albums = Album.recent(3)
    assert_not_includes(recent_albums, @album2)
  end

  test "should return 4 albums as most recent albums" do
    @album.save
    @album2.save
    @album3.save
    @album4.save
    @album5.save
    recent_albums = Album.most_recent
    assert_equal(4, recent_albums.size)
  end


end
