require 'test_helper'

class TermsControllerTest < ActionDispatch::IntegrationTest

  test "test fetching terms page" do
    get terms_url
    assert_response 200
  end
end
