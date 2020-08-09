require 'test_helper'

class AboutusControllerTest < ActionDispatch::IntegrationTest

  test "test fetching about us page" do
    get aboutus_url
    assert_response 200
  end
end
