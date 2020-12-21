require 'rails_helper'

RSpec.describe "物件登録", type: :request do
  let!(:user) { create(:user) }
  let!(:property) { create(:property, user: user) }

  context "ログインしているユーザーの場合" do
    before do
      login_for_request(user)
      get new_property_path
    end
    
    it "レスポンスが正常に表示されること" do
      expect(response).to have_http_status "200"
      expect(response).to render_template('properties/new')
    end

    it "有効な物件データで登録できること" do
      expect {
        post properties_path, params: { property: { name: "Shimokitaマンション",
                                                    description: "下北沢駅南口より徒歩5分の物件です！",
                                                    reference: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/",
                                                    recommend: 5 } }
        }.to change(Property, :count).by(1)
        follow_redirect!
        expect(response).to render_template('properties/show')
    end

    it "無効な物件データーでは登録できないこと" do
      expect {
        post properties_path, params: { property: { name: "",
                                                    description: "下北沢駅南口より徒歩5分の物件です！",
                                                    reference: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/",
                                                    recommend: 5 } }
        }.not_to change(Property, :count)
        expect(response).to render_template('properties/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_property_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
