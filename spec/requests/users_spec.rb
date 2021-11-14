require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "users" do
    
    let (:user_params) { { user: { name: @user.name, email: @user.email, uid: @user.uid, profile: @user.profile} } }
    it"get /users/index" do
        get api_v1_users_path 
        expect(response).to have_http_status(200)
    end

    it "post /users/create" do
      @user = build(:user)
      post api_v1_users_path, params: user_params
      expect(response).to have_http_status(200)
    end

    it "get /user/show" do
      user = create(:user)
      get api_v1_user_path(user.id)
      STDOUT.puts "hogehoge"
      STDOUT.puts "hogehoge"
      expect(response).to have_http_status(200)
    end

    it "delete /user/destroy" do
      @user = create(:user)
      delete api_v1_user_path(@user.id)
      expect(response).to have_http_status(204)
    end

    it "post /user/search" do
      user = create(:user)
      post search_api_v1_users_path, params: {name: user.name}
      expect(response).to have_http_status(200)
    end

    it "patch /user/update" do
      @user = create(:user)
      patch api_v1_user_path(@user.id), params: user_params
      expect(response).to have_http_status(200)
    end
  end
end
