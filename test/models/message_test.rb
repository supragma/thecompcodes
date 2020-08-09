require 'test_helper'

class MessageTest < ActiveSupport::TestCase
   test "create a message" do
     message = Message.create(name: "name", email: "email", message: "message")
     assert message.valid?
   end
end
