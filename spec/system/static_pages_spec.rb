require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "yeahlogの文字列が存在することを確認" do
        expect(page).to have_content 'yeahlog'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      context "物件フィード", js: true do
        let!(:user) { create(:user) }
        let!(:property) { create(:property, user: user)}

        before do
          login_for_system(user)
        end

        it "物件を削除後、削除成功のフラッシュが表示されること" do
          visit root_path
          click_on '削除'
          page.driver.browser.switch_to.alert.accept
          expect(page).to have_content '物件が削除されました'
        end

        it "物件のページネーションが表示されること" do
          create_list(:property, 6, user: user)
          visit root_path
          expect(page).to have_content "物件一覧 (#{user.properties.count})"
          expect(page).to have_css "div.pagination"
          Property.take(5).each do |p|
            expect(page).to have_link p.name
          end
        end

        it "「物件を登録する」リンクが表示されること" do
          visit root_path
          expect(page).to have_link "物件を登録する", href: new_property_path
        end
      end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "yeahlogとは？の文字列が存在することを確認" do
      expect(page).to have_content 'yeahlogとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('yeahlogとは？')
    end
  end

  describe "利用規約ページ" do
    before do
      visit use_of_terms_path
    end
    
    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end  
end
