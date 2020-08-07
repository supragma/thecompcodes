require 'test_helper'

class PrivacyControllerTest < ActionDispatch::IntegrationTest

  test "test fetching privacy page" do
    get privacy_url
    assert_response 200
  end
end
