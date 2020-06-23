module Helpers
  # Helper method to parse a response
  #
  # @return [Hash]
  def json
    JSON.parse(response.body)
  end

  def auth_headers
    token = Knock::AuthToken.new(payload: { user_id: user.id }).token
    {'Authorization': "Token #{token}"}
  end
end
