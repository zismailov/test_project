require 'rails_helper'

RSpec.describe FoosController, type: :controller do
  let(:foo) { create(:foo) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns paginated foos" do
      # Создаем более 10 записей Foo, чтобы проверить пагинацию
      create_list(:foo, 15)
      get :index
      expect(assigns(:foos).count).to eq(10)
    end
  end

  describe "GET #show" do

    it "returns a successful response" do
      get :show, params: { id: foo.id }
      expect(response).to be_successful
    end

    it "assigns the requested foo" do
      get :show, params: { id: foo.id }
      expect(assigns(:foo)).to eq(foo)
    end

    it "assigns paginated bars" do
      create_list(:bar, 6, foo: foo)
      get :show, params: { id: foo.id }
      expect(assigns(:bars).count).to eq(5)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Foo" do
        expect do
          post :create, params: { foo: attributes_for(:foo) }
        end.to change(Foo, :count).by(1)
      end

      it "redirects to the foos index page" do
        # Проверяем, что после успешного создания Foo происходит редирект на страницу списка Foo
        # Это соответствует логике контроллера, которая была изменена с редиректа на созданный Foo.
        post :create, params: { foo: attributes_for(:foo) }
        expect(response).to redirect_to(foos_path)
      end
    end

    context "with invalid params" do
      it "does not create a new Foo" do
        expect do
          post :create, params: { foo: { name: nil } }
        end.not_to change(Foo, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested foo" do
      foo_to_delete = create(:foo)
      expect do
        delete :destroy, params: { id: foo_to_delete.id }
      end.to change(Foo, :count).by(-1)
    end

    it "redirects to the foos list" do
      delete :destroy, params: { id: foo.id }
      expect(response).to redirect_to(foos_url)
    end
  end
end