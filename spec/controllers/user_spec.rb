require 'rails_helper'

RSpec.describe 'user API', type: :request do

  describe 'POST /api/v1/users/', type: :request do
      let(:user)            { User.last }
      let(:failed_response) { 422 }

      describe 'POST create' do
        let(:url)                   { '/api/v1/users/' }
        let(:email)                 { 'test@test.com' }
        let(:password)              { '12345678' }
        let(:params) do
          {
              email: email,
              password: password
          }
        end

        it 'returns a successful response' do
          post url, params: params, as: :json
          expect(response).to have_http_status(:success)
          expect(response).to have_http_status(201)
          body = JSON.parse(response.body)
          expect(body['message']).to eq('User created successfully')

        end

        it 'creates the user' do
          expect {
            post url, params: params, as: :json
          }.to change(User, :count).by(1)
        end


        context 'when the email is not correct' do
          let(:email) { 'invalid_email' }

          it 'does not create a user' do
            expect {
              post url, params: params, as: :json
            }.not_to change { User.count }
          end

          it 'does not return a successful response' do
            post url, params: params, as: :json

            expect(response.status).to eq(400)
          end
        end
      end
  end

  describe 'GET api/v1/users/', type: :request do
    let(:url)  { '/api/v1/users/' }
    # let(:user) { create(:user) }
    let!(:users) { create_list(:user, 10) }
    let(:user) { users.first }

    it 'returns success' do
      get url, headers: auth_headers, as: :json
      expect(response).to have_http_status(:success)
    end

    it "returns the logged in user's data" do
      get url, headers: auth_headers
      expect(response).to have_http_status(200)
      expect(json.size).to be 10
      expect(json[0]['email']).to eq user.email
    end
  end

  describe 'GET api/v1/users/:id', type: :request do
    let(:user) { create(:user) }

    it 'returns success' do
      get "/api/v1/users/#{user.id}", headers: auth_headers, as: :json
      expect(response).to have_http_status(:success)
      expect(json["id"]).to eq user.id
      expect(json["email"]).to eq user.email
    end
  end

end
