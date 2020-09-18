require 'test_helper'

class GetitnowControllerTest < ActionDispatch::IntegrationTest

  test "test getting contact us page" do
    get getitnow_url
    assert_response 200
  end

  test "test posting contact us page" do
    post getitnow_url, params: { email: "some@email.com",
                                 name: "myname",
                                 phone: "123456789",
                                 size: "2000-2500"}
    assert @response.redirect_url.include? "contactus"
  end
end
