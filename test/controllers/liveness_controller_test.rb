require 'test_helper'

class LivenessControllerTest < ActionDispatch::IntegrationTest

  test "test failure liveness" do
    get api_v1_failure_url
    assert_response 400
  end

  test "test success liveness" do
    get api_v1_liveness_url
    assert_response 200
  end
  
end
