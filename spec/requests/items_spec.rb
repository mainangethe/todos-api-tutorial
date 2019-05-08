require 'rails_helper'

RSpec.describe 'Items API' do
  let!(:todo) { create(:todo) }
  let!(:items) { create_list(:item, 20, todo_id: todo.id) }
  let(:todo_id) { todo.id }
  let(:item_id) { items.first.id }

  # GET /todos/:todo_id/items
  describe 'GET /todos/:todo_id/items' do
    before { get "/todos/#{todo_id}/items" }

    context 'when todo exists' do
      
      it 'returns status code: 200' do
        expect(response).to have_http_status 200
      end

      it 'returns all todo items' do
        expect(json.size).to eq 20
      end

    end

    context 'when todo does not exist' do
      let(:todo_id) { 0 }

      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns "not found" message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

    end

  end

  # GET /todos/:todo_id/items/:id
  describe 'GET /todos/:todo_id/items/:id' do
    before { get "/todos/#{ todo_id }/items/#{ item_id }" }

    context 'when todo item exists' do
      it 'returns status code: 200' do
        expect(response).to have_http_status 200
      end

      it ' returns the item' do
        expect(json['id']).to eq item_id
      end

    end

    context "when todo item exists but item doesn't" do
      let(:item_id ) { 0 }
      
      it 'returns a status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a "not found" message' do
        expect(response.body).to match(/Couldn't find Item/)
      end

    end

    context "when todo item doesn't exist" do
      let(:todo_id) { 0 }
      
      it 'returns a status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a "not found" message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

    end

  end

  # POST /todos/:todo_id/items
  describe 'POST /todos/:todo_id/items' do
    let(:valid_attributes) { { name: 'Visit Ongwaro', done: false } }

    context 'when request attributes are valid' do
      before { post "/todos/#{ todo_id }/items", params: valid_attributes }

      it 'returns status code: 201' do
        expect(response).to have_http_status 201
      end

    end

    context 'when todo is invalid' do
      let(:todo_id) { 0 }
      before { post "/todos/#{ todo_id }/items", params: valid_attributes }

      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a failure message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end
      
    end

    context 'when request attributes are invalid' do
      before { post "/todos/#{ todo_id }/items", params: {} }

      it 'returns status code: 422' do
        expect(response).to have_http_status 422
      end

      it 'returns a failure message' do
        expect(response.body)
          .to match(/Validation failed: Name can't be blank/)
      end

    end

  end

  # PUT /todos/:todo_id/items/:id
  describe 'PUT /todos/:todo_id/items/:id' do
    let(:valid_attributes) { { name: 'Tuishie Kajiado' } }

    before { put "/todos/#{ todo_id }/items/#{ item_id }", params: valid_attributes }

    context 'when item exists' do
      it 'returns status code: 204' do
        expect(response).to have_http_status 204
      end

      it 'updates the content' do
        updated_item = Item.find(item_id)
        expect(updated_item.name).to match(/Tuishie Kajiado/)
      end

    end

    context "when item doesn't exist" do
      let(:item_id) { 0 }

      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a "not found" message' do
        expect(response.body).to match(/Couldn't find Item/)
      end

    end

    context "when todo doesn't exist" do
      let(:todo_id) { 0 }
      
      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a "not found" message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

    end

  end

  # DELETE /todos/:todo_id/items/:item_id
  describe 'DELETE /todos/:todo_id/items/:id' do
    before { delete "/todos/#{ todo_id }/items/#{ item_id }" }

    context "item exists" do
      it 'returns status code: 204' do
        expect(response).to have_http_status 204
      end
    end
    context "item doesn't exist" do
      let(:item_id) { 0 }
      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns a "not found" message' do
        expect(response.body).to match(/Couldn't find Item/)
      end

    end

    context "todo doesn't exist" do
      let(:todo_id) { 0 }

      it 'returns status code: 404' do
        expect(response).to have_http_status 404
      end

      it 'returns "not found" message' do
        expect(response.body).to match(/Couldn't find Todo/)
      end

    end

  end

end