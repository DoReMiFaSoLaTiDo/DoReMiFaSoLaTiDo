require 'test_helper'

class AlbumsControllerTest < ActionController::TestCase

  setup do
    @album = albums(:one)
    @albums = Album.all
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:albums)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create album" do
    assert_difference('Album.count') do
      post :create, album: { cover_art: @album.cover_art, name: @album.name, publisher_id: @album.publisher_id, released_on: @album.released_on }
    end

    assert_redirected_to album_path(assigns(:album))
  end

  test "should show album" do
    get :show, id: @album.id
    assert_response :success
    # assert_redirected_to album_path(assigns(:album))
  end

  test "should get edit" do
    get :edit, id: @album.id
    assert_response :success
  end

  test "should update album" do
    patch :update, id: @album, album: { cover_art: @album.cover_art, name: @album.name, publisher_id: @album.publisher_id, released_on: @album.released_on }
    assert_redirected_to album_path(assigns(:album))
  end

  test "should get newest album" do
    get :newest
    assert_response :success
  end


  # TODO album destroy tests

end
