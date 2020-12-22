require "rails_helper"

RSpec.describe "物件詳細ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:property) { create(:property, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get property_path(property)
      expect(response).to have_http_status "200"
      expect(response).to render_template('properties/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get property_path(property)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end