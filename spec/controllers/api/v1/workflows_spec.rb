# frozen_string_literal: true

require 'rails_helper'

describe 'Workflow API', type: :request do
  let(:user) { create(:user) }
  let(:request) { create(:request) }
  let(:workflow_status) { 'active' }
  let(:workflow) { create(:workflow, user: user, request: request, status: 'active') }
  let(:workflow_response) do
    {
      id: workflow.id,
      status: workflow.status,
      user_id: workflow.user_id,
      request_id: workflow.request_id,
      status: workflow_status,
      request_name: request.name
    }.with_indifferent_access
  end

  describe 'Fetch workflows: GET /api/v1/workflows' do
    subject(:fetch_workflows) do
      get api_v1_workflows_path, headers: valid_header(user)
    end

    context 'when there is no workflow' do
      it 'returns empty array' do
        fetch_workflows
        response_body = JSON.parse(response.body)
        expect(response_body).to eql([])
        expect(response.status).to eql(200)
      end
    end

    context 'when workflow is present' do
      let(:response_body) do
        [
          workflow_response
        ]
      end

      before do
        workflow
      end

      it 'returns array of workflow objects' do
        fetch_workflows
        expect(JSON.parse(response.body)).to eql(response_body)
      end
    end
  end

  describe 'Get workflow: Get /api/v1/workflows/<id>' do
    subject(:get_workflow) do
      get api_v1_workflow_path(id), headers: valid_header(user)
    end

    context 'when workflow not found' do
      let(:id) { 100 }
      it 'returns 404 error' do
        get_workflow
        expect(response.status).to eql(404)
      end
    end

    context 'when workflow is present' do
      let(:id) { workflow.id }

      it 'returns workflow object' do
        get_workflow
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)).to eql(workflow_response)
      end
    end
  end

  describe 'Update workflow: put /api/v1/workflows/<id>' do
    subject(:update_workflow) do
      put  api_v1_workflow_path(id: id, workflow: { status: 'inactive' }), headers: valid_header(user)
    end

    context 'when workflow not found' do
      let(:id) { 100 }
      it 'returns 404 error' do
        update_workflow
        expect(response.status).to eql(404)
      end
    end

    context 'when workflow is present' do
      let(:id) { workflow.id }
      let(:workflow_status) { 'inactive' }

      it 'returns workflow object' do
        update_workflow
        expect(response.status).to eql(200)
        expect(JSON.parse(response.body)).to eql(workflow_response)
      end
    end
  end

  describe 'Create workflow: post /api/v1/workflows' do
    let(:request_id) { request.id }
    let(:user_id) { user.id }
    let(:params) do
      {
        user_id: user_id,
        request_id: request_id,
        status: 'active'
      }
    end

    subject(:create_workflow) do
      post api_v1_workflows_path(workflow: params), headers: valid_header(user)
    end

    context 'when workflow creates successfully' do
      it 'creates workflow and returns workflow object' do
        create_workflow
        expect(response.status).to eql(201)
      end
    end

    context 'when error occurs' do
      let(:user_id) { nil }
      it 'returns with unprocessable entity error' do
        create_workflow
        expect(response.status).to eql(422)
      end
    end

    context 'when request_id is invalid' do
      let(:request_id) { request.id + 1000 }

      it 'returns error with request_id must exist message' do
        create_workflow
        expect(response.status).to eql(422)
      end
    end

    context 'when user_id is invalid' do
      let(:user_id) { user.id + 1000 }

      it 'returns error with request_id must exist message' do
        create_workflow
        expect(response.status).to eql(422)
      end
    end
  end

  describe 'Delete workflow: DELETE /api/v1/workflows/<id>' do
    subject(:delete_workflow) do
      delete api_v1_workflow_path(id), headers: valid_header(user)
    end

    context 'when workflow is present' do
      let(:id) { workflow.id }

      it 'deletes workflow' do
        delete_workflow
        expect(JSON.parse(response.body)['message']).to eql('Workflow has been deleted')
      end
    end

    context 'when workflow not found' do
      let(:id) { 100 }
      it 'returns 404 error' do
        delete_workflow
        expect(response.status).to eql(404)
      end
    end
  end
end
