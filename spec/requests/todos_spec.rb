# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Todos API', type: :request do
  # initialize test data
  let!(:todos) { create_list(:todo, 10) }
  let(:todo_id) { todos.first.id }

  # Get all
  describe 'GET /todos' do
    # make HTTP get request before each example
    before { get '/todos' }

    it 'returns all todos' do
      # Note `json` is a custom helper to parse JSON responses
      expect(json).not_to be_empty
      expect(json.size).to eq 10
    end

    it 'returns status code:200' do
      expect(response).to have_http_status(200)
    end
  end

  # Get single todo
  describe 'Get /todos/:id' do
    before { get "/todos/#{todo_id}" }

    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq todo_id
      end

      it 'returns status code: 200' do
        expect(response).to have_http_status 200
      end
    end

    context "when the record doesn't exist" do
      let(:todo_id) { 100 }

      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it "returns a 'Not Found' message" do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # POST /todos
  describe 'POST /todos' do
    # valid payload
    let(:valid_attributes) do
      { title: 'Learn Elm', created_by: 'John Doe' }
    end

    context 'when the request is valid' do
      before { post '/todos', params: valid_attributes }

      it 'creates a todo' do
        expect(json['title']).to eq 'Learn Elm'
      end

      it 'returns status code: 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/todos', params: { title: 'Am the only one' } }

      it 'returns status code 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end
  end

  # PUT /todos/:id
  describe 'PUT /todos/:id' do
    let(:valid_attributes) { { title: 'Shopping' } }

    context 'when the record exists' do
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code: 204' do
        expect(response).to have_http_status 204
      end
    end

    context 'when the attributes are invalid' do
      before { put "/todos/#{todo_id}", params: { created_by: nil } }

      it 'returns status code: 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a validation failure message' do
        expect(response.body)
          .to match(/Validation failed: Created by can't be blank/)
      end
    end

    context "when the record doesn't exist" do
      let(:todo_id) { 100 }
      before { put "/todos/#{todo_id}", params: valid_attributes }

      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it "returns a 'not found' message" do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end

  # DELETE /todos/:id
  describe 'DELETE /todos/:id' do
    context 'when the record exists' do
      before { delete "/todos/#{todo_id}" }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code: 204' do
        expect(response).to have_http_status 204
      end
    end

    context "when the record doesn't exist" do
      let(:todo_id) { 100 }
      before { delete "/todos/#{todo_id}" }

      it 'returns status  code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a "Not Found" message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
    end
  end
end
