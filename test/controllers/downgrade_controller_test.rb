require 'test_helper'

class DowngradeControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get downgrade_new_url
    assert_response :success
  end

end
