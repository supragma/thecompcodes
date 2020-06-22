require 'rails_helper'

RSpec.describe 'user API', type: :request do
  # initialize test data 
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id }

  describe 'POST /users' do
    let(:valid_attributes) { { email: 'test@gmail.com', password: '12345@' } }

    context 'valid request' do
      before { post '/api/v1/users', params: valid_attributes }
      it 'creates an user' do
        expect(response).to have_http_status(201)
        body = JSON.parse(response.body)
        expect(body['message']).to eq('User created successfully')
      end
    end

    context 'invalid request' do
      before { post '/api/v1/users', params: { email: 'test1@gmail.com', password: '12345' } }
      it 'validation error' do
        expect(response).to have_http_status(400)
        expect(response.body)
          .to match('{"password":["is too short (minimum is 6 characters)"]}')
      end
    end
  end

  describe 'GET /users' do
    before { get '/api/v1/users' }

    it 'check users exists and status code 200' do
      expect(response.body).not_to be_empty
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body.size).to be 10
    end
  end

  describe 'GET /users/:id' do
    before { get "/api/v1/users/#{user_id}" }

    it 'check users exists and status code 200' do
      expect(response.body).not_to be_empty
      expect(response).to have_http_status(200)
      body = JSON.parse(response.body)
      expect(body['id']).to eq(user_id)
    end
  end


end
