require 'test_helper'

class WishlistControllerTest < ActionDispatch::IntegrationTest
  test "should get album_id:integer" do
    get wishlist_album_id:integer_url
    assert_response :success
  end

end
