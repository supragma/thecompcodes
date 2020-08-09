require 'test_helper'

class SubscribeControllerTest < ActionDispatch::IntegrationTest

  test "test posting subscribe" do
    post subscribe_url, params: { femail: "email@email.com" }
    assert_response :redirect
    assert @response.redirect_url.include? "contactus"
  end
end
