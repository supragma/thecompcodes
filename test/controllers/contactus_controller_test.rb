require 'test_helper'

class ContactusControllerTest < ActionDispatch::IntegrationTest

  test "test getting contact us page" do
    get contactus_url
    assert_response 200
  end

  test "test posting contact us page" do
    post contactus_url, params: { email: "some@email.com",
                                  name: "myname",
                                  message: "mymessage" }
    assert_response 200
    #TODO test that the message has hit the database
  end
end
