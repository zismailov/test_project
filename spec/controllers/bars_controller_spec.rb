require 'rails_helper'

RSpec.describe BarsController, type: :controller do
  let(:foo) { create(:foo) }
  let(:valid_attributes) { { name: 'Test Bar', description: 'Test Description' } }
  let(:invalid_attributes) { { name: nil, description: nil } }

  describe "GET #index" do
    it "returns a successful response" do
      get :index, params: { foo_id: foo.id }, format: :turbo_stream
      expect(response).to be_successful
      expect(response.media_type).to eq Mime[:turbo_stream]
    end

    it "assigns paginated bars" do
      # Создаем более 5 записей Bar, чтобы проверить пагинацию
      create_list(:bar, 6, foo: foo)
      get :index, params: { foo_id: foo.id }, format: :turbo_stream
      expect(assigns(:bars).count).to eq(5)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Bar" do
        expect do
          post :create, params: { foo_id: foo.id, bar: valid_attributes }, format: :turbo_stream
        end.to change(Bar, :count).by(1)
      end

      it "renders turbo stream response" do
        post :create, params: { foo_id: foo.id, bar: valid_attributes }, format: :turbo_stream
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response).to have_http_status(:success)
      end
    end

    context "with invalid params" do
      it "does not create a new Bar" do
        expect do
          post :create, params: { foo_id: foo.id, bar: invalid_attributes }, format: :turbo_stream
        end.not_to change(Bar, :count)
      end

      it "renders turbo stream with errors" do
        post :create, params: { foo_id: foo.id, bar: invalid_attributes }, format: :turbo_stream
        expect(response.media_type).to eq Mime[:turbo_stream]
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let!(:bar) { create(:bar, foo: foo) }

    it "destroys the requested bar" do
      # Проверяем, что количество записей Bar уменьшается на 1 после удаления
      expect do
        delete :destroy, params: { foo_id: foo.id, id: bar.id }, format: :turbo_stream
      end.to change(Bar, :count).by(-1)
    end

    it "renders turbo stream response" do
      delete :destroy, params: { foo_id: foo.id, id: bar.id }, format: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
      expect(response).to have_http_status(:success)
    end
  end
end