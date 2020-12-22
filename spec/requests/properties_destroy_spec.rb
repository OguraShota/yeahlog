require "rails_helper"

RSpec.describe "物件の削除", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:property) { create(:property, user: user) }

  context "ログインしていて、自分の物件を削除する場合" do
    it "処理が成功し、トップページにリダイレクトすること" do
      login_for_request(user)
      expect {
        delete property_path(property)
      }.to change(Property, :count).by(-1)
      redirect_to user_path(user)
      follow_redirect!
      expect(response).to render_template('static_pages/home')
    end
  end

  context "ログインしていて、他人の物件を削除する場合" do
    it "処理が失敗し、トップページにリダイレクトすること" do
      login_for_request(other_user)
      expect {
        delete property_path(property)
      }.not_to change(Property, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end

  context "ログインしていない場合" do
    it "ログインページへリダイレクトすること" do
      expect {
        delete property_path(property)
      }.not_to change(Property, :count)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end