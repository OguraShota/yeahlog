require 'rails_helper'

RSpec.describe Property, type: :model do
  let!(:dish_yesterday) { create(:property, :yesterday) }
  let!(:dish_one_week_ago) { create(:property, :one_week_ago) }
  let!(:dish_one_month_ago) { create(:property, :one_month_ago) }
  let(:property) { create(:property) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(property).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      property = build(:property, name: nil)
      property.valid?
      expect(property.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      property = build(:property, name: "あ" * 31)
      property.valid?
      expect(property.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      property = build(:property, description: "あ" * 141)
      property.valid?
      expect(property.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      property = build(:property, user_id: nil)
      property.valid?
      expect(property.errors[:user_id]).to include("を入力してください")
    end

    it "オススメ度が1以上でなければ無効な状態であること" do
      property = build(:property, recommend: 0)
      property.valid?
      expect(property.errors[:recommend]).to include("は1以上の値にしてください")
    end

    it "オススメ度が5以下でなければ無効な状態であること" do
      property = build(:property, recommend: 6)
      property.valid?
      expect(property.errors[:recommend]).to include("は5以下の値にしてください")
    end

    context "並び順" do
      it "最も最近の投稿が最初の投稿になっていること" do
        expect(property).to eq Property.first
      end
    end
  end
end
