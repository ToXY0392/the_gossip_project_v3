require "test_helper"

class GossipsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gossip_url(gossips(:one))
    assert_response :success
  end
end
