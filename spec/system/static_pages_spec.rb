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

        it "物件のページネーションが表示されること" do
          login_for_system(user)
          create_list(:property, 6, user: user)
          visit root_path
          expect(page).to have_content "物件一覧 (#{user.properties.count})"
          expect(page).to have_css "div.pagination"
          Property.take(5).each do |p|
            expect(page).to have_link p.name
          end
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
