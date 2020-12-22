require 'rails_helper'

RSpec.describe "Dishes", type: :system do
  let!(:user) { create(:user) }
  let!(:property) { create(:property, :picture, user: user) }

  describe "物件登録ページ" do
    before do
      login_for_system(user)
      visit new_property_path
    end

    context "ページレイアウト" do
      it "「物件登録」の文字列が存在すること" do
        expect(page).to have_content '物件登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('物件登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '物件名'
        expect(page).to have_content '説明'
        expect(page).to have_content '物件詳細URL'
        expect(page).to have_content 'オススメ度 [1~5]'
      end
    end

    context "物件登録処理" do
      it "有効な情報で物件登録を行うと料理登録成功のフラッシュが表示されること" do
        fill_in "物件名", with: "ハイツ池ノ上"
        fill_in "説明", with: "池ノ上駅より徒歩5分"
        fill_in "物件詳細URL", with: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/"
        fill_in "オススメ度", with: 3
        attach_file "property[picture]", "#{Rails.root}/spec/fixtures/property1.jpg"
        click_button "登録する"
        expect(page).to have_content "物件が登録されました!"
      end

      it "無効な情報で物件登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "物件名", with: ""
        fill_in "説明", with: "池ノ上駅より徒歩5分"
        fill_in "物件詳細URL", with: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/"
        fill_in "オススメ度", with: 3
        click_button "登録する"
        expect(page).to have_content "物件名を入力してください"
      end

      # it "画像無しで登録すると、デフォルト画像が割り当てられること" do
      #   fill_in "物件名", with: "ハイツ池ノ上"
      #   click_button "登録する"
      #   expect(page).to have_link(href: property_path(Property.first))
      # end
    end
  end

  describe "物件詳細ページ" do
    context "ページレイアウト" do
      before do
        login_for_system(user)
        visit property_path(property)
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title("#{property.name}")
      end

      it "物件情報が表示されること" do
        expect(page).to have_content property.name
        expect(page).to have_content property.description
        expect(page).to have_content property.reference
        expect(page).to have_content property.recommend
        expect(page).to have_link nil, href: property_path(property), class: 'property-picture'
      end
    end

    context "物件の削除", js: true do
      it "削除成功のフラッシュが表示されること" do
        login_for_system(user)
        visit property_path(property)
        within find('.change-property') do
          click_on '削除'
        end
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '物件が削除されました'
      end
    end
  end

  describe "物件編集ページ" do
    before do
      login_for_system(user)
      visit property_path(property)
      click_link "編集"
    end

    context "ページレイアウト" do
      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('物件情報の編集')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content '物件名'
        expect(page).to have_content '説明'
        expect(page).to have_content '物件詳細URL'
        expect(page).to have_content 'オススメ度 [1~5]'
      end
    end

    context "物件の削除処理", js: true do
      it "削除成功のフラッシュが表示されること" do
        click_on '削除'
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content '物件が削除されました'
      end
    end

    context "物件の更新処理" do
      it "有効な更新" do
        fill_in "物件名", with: "編集:ハイツ池ノ上"
        fill_in "説明", with: "編集:池ノ上駅より徒歩5分"
        fill_in "物件詳細URL", with: "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/"
        fill_in "オススメ度", with: 2
        attach_file "property[picture]", "#{Rails.root}/spec/fixtures/property2.jpg"
        click_button "更新する"
        expect(page).to have_content "物件情報が更新されました！"
        expect(property.reload.name).to eq "編集:ハイツ池ノ上"
        expect(property.reload.description).to eq "編集:池ノ上駅より徒歩5分"
        expect(property.reload.reference).to eq "https://suumo.jp/library/tf_13/sc_13112/to_1000617572/"
        expect(property.reload.recommend).to eq 2
        expect(property.reload.picture.url).to include "property2.jpg"
      end

      it "無効な更新" do
        fill_in "物件名", with: ""
        click_button "更新する"
        expect(page).to have_content "物件名を入力してください"
        expect(property.reload.name).not_to eq ""
      end
    end
  end
end