require 'rails_helper'

RSpec.describe ItemMaster, type: :model do
  context "講座マスターが正しく登録できる" do

    let(:current_user) {FactoryBot.build(:user)}
    let(:item_master) {FactoryBot.build(:item_master)}

    it "講座マスターが登録できる" do
      current_user.item_masters << item_master
      expect(current_user.item_masters.first.present?).to be_truthy
    end

    it "講座コードが空白はNG" do
      item_master.code = ""
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座コードが0はNG" do
      item_master.code = 0
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座コードが1はOK" do
      item_master.code = 1
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_valid
    end

    it "講座コードが9999はOK" do
      item_master.code = 9999
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_valid
    end

    it "講座コードが10000以上はNG" do
      item_master.code = 10000
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座コードが小数はNG" do
      item_master.code = 1.5
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座コードが負の数はNG" do
      item_master.code = -1.5
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座コードが全角はNG" do
      item_master.code = "１．５"
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end


    it "カテゴリが空白はNG" do
      item_master.category = ""
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "カテゴリが負の数はNG" do
      item_master.category = -1
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "カテゴリが4以上はNG" do
      item_master.category = 4
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "カテゴリが全角はNG" do
      item_master.category = "２"
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座名が空白はNG" do
      item_master.name = ""
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "講座名が21字以上はNG" do
      item_master.name = "１２３４５６７８９０１２３４５６７８９０１"
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "価格が空白はNG" do
      item_master.price = ""
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "価格が負の値はOK" do
      item_master.price = "-1.5"
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_valid
    end

    it "価格が数式はNG" do
      item_master.price = "1+2"
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

    it "価格が全角文字はNG" do
      item_master.price = "１２３"
      current_user.item_masters << item_master
      expect(current_user.item_masters.first).to be_invalid
    end

  end
end