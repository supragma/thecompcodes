# frozen_string_literal: true

require 'rails_helper'

describe 'Request API', type: :request do
  let(:user) { create(:user) }
  let(:request_name) {'test request'}
  let(:request) { create(:request, name: request_name, description: '...') }
  let(:request_response) do
    {
      id: request.id,
      name: request_name,
      description: request.description,
    }.with_indifferent_access
  end

  describe 'Fetch requests: GET /api/v1/requests' do
    subject(:fetch_requests) do
      get api_v1_requests_path, headers: valid_header(user)
    end

    context 'when there is no request' do
      it 'returns empty array' do
        fetch_requests
        response_body = JSON.parse(response.body)
        expect(response_body).to eql([])
        expect(response.status).to eql(200)
      end
    end

    context 'when request is present' do
      let(:response_body) do
        [
          request_response
        ]
      end

      before do
        request
      end

      it 'returns array of request objects' do
        fetch_requests
        expect(JSON.parse(response.body)).to eql(response_body)
      end
    end
  end

  describe 'Get request: Get /api/v1/requests/<id>' do
    subject(:get_request) do
      get api_v1_request_path(id), headers: valid_header(user)
    end

    context 'when request not found' do
      let(:id) { 100 }
      it 'returns 404 error' do
        get_request
        expect(response.status).to eql(404)
      end
    end

    context 'when request is present' do
      let(:id) { request.id }

      it 'returns request object' do
        get_request
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)).to eql(request_response)
      end
    end
  end

  describe 'Update request: put /api/v1/requests/<id>' do
    subject(:update_request) do
      put  api_v1_request_path(id: id, request: { name: 'test.' }), headers: valid_header(user)
    end

    context 'when request not found' do
      let(:id) { 100 }
      it 'returns 404 error' do
        update_request
        expect(response.status).to eql(404)
      end
    end

    context 'when request is present' do
      let(:id) { request.id }
      let(:request_name) { 'test.' }

      it 'returns request object' do
        update_request
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)).to eql(request_response)
      end
    end
  end

  describe 'Create request: post /api/v1/requests' do
    
    let(:params) do
      {
        name: "test11",
        description: "..."
      }
    end

    subject(:create_request) do
      post api_v1_requests_path(request: params), headers: valid_header(user)
    end

    context 'when request creates successfully' do
      it 'creates request and returns request object' do
        create_request
        expect(response.status).to eql(201)
      end
    end

    context 'when error occurs' do
      let(:params) do
          {description: "..."}
        end
      it 'returns with unprocessable entity error name cannot be blank' do
        create_request
        expect(response.status).to eql(422)
      end
    end

  end

  describe 'Delete request: DELETE /api/v1/requests/<id>' do
    subject(:delete_request) do
      delete api_v1_request_path(id), headers: valid_header(user)
    end

    context 'when request is present' do
      let(:id) { request.id }

      it 'deletes request' do
        delete_request
        expect(JSON.parse(response.body)['message']).to eql('Request has been deleted')
      end
    end

    context 'when request not found' do
      let(:id) { 100 }
      it 'returns 404 error' do
        delete_request
        expect(response.status).to eql(404)
      end
    end
  end
end
