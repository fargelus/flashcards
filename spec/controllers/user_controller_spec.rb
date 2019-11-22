require 'rails_helper'

RSpec.describe UserController, type: :controller do

  describe "GET #email:string" do
    it "returns http success" do
      get :email:string
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #crypted_password:string" do
    it "returns http success" do
      get :crypted_password:string
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET #salt:string" do
    it "returns http success" do
      get :salt:string
      expect(response).to have_http_status(:success)
    end
  end

end
