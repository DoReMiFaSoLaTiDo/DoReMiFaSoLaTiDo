require 'test_helper'

class ArtistTest < ActiveSupport::TestCase
  setup do
    @artist = artists(:one)
  end

  test "return default image when no image pre-saved" do
    @artist.save
    assert_equal("/art/01-13264.jpg", @artist.image_url)
  end

  test "return true image when image exists" do
    @artist.image = 'true_image.jpg'
    @artist.save
    assert_equal("true_image.jpg", @artist.image_url)
  end
end
