require "rails_helper"

RSpec.describe "物件編集", type: :request do
  let!(:user) { create(:user) }
  let!(:property) { create(:property, user: user) }
  let!(:other_user) { create(:user) }
  let(:picture2_path) { File.join(Rails.root, 'spec/fixtures/property2.jpg') } 
  let(:picture2) { Rack::Test::UploadedFile.new(picture2_path) } 


  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_property_path(property)
      login_for_request(user)
      expect(response).to redirect_to edit_property_url(property)
      patch property_path(property), params: { property: { name: "Shimokitaマンション",
                                                           description: "下北沢駅南口より徒歩5分の物件です！",
                                                           reference: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/",
                                                           recommend: 5,
                                                           picture: picture2 } }
      redirect_to property
      follow_redirect!
      expect(response).to render_template('properties/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      #編集
      get edit_property_path(property)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      #更新
      patch property_path(property), params: { property: { name: "Shimokitaマンション",
                                                           description: "下北沢駅南口より徒歩5分の物件です！",
                                                           reference: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/",
                                                           recommend: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      # 編集
      login_for_request(other_user)
      get edit_property_path(property)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      # 更新
      patch property_path(property), params: { property: { name: "Shimokitaマンション",
                                                           description: "下北沢駅南口より徒歩5分の物件です！",
                                                           reference: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/",
                                                           recommend: 5 } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end