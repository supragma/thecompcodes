require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest

  test "test fetching homepage" do
    get root_url
    assert_response 200
  end
end
