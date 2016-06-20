require 'test_helper'

class SongsTest < ActionDispatch::IntegrationTest
  test "page has form element" do
    get '/songs'
    assert_response :success
    assert_select "form", true,
      "Page doesn't have a form element"
  end

  

end
