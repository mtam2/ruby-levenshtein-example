require 'rails_helper'

RSpec.describe User, type: :model do
  
  User.delete_all

  subject { FactoryBot.build(:user_1) }
  
  describe "validations" do
    it { should validate_presence_of :email }
    it { should have_many :similar_emails }

    it "accepts valid attributes" do
      expect(subject).to be_valid
    end
  end

  describe "methods" do
    user_1 = FactoryBot.create(:user_1)
    user_2 = FactoryBot.create(:user_2)

    it "should frequencies of all user emails" do
      expect(subject.class.calculate_frequency).not_to be_empty
    end

    it "should calculate possible duplicate emails to a JSON response" do
      expect(subject.class.possible_duplicate_emails.dig(:levenshtein_distances)).not_to be_empty
    end
  end

end
