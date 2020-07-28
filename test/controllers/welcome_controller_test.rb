require 'test_helper'

class WelcomeControllerTest < ActionDispatch::IntegrationTest
   test "the truth" do
     get root_url
     assert_response :success
   end
end
