require 'test_helper'

class SubscribeTest < ActiveSupport::TestCase
  test "fetching a fixture" do
    subscriber = Subscribe.new(email: "MyEmail")
    assert subscriber.valid?
  end
end
