require 'rails_helper'

RSpec.describe SimilarEmail, type: :model do
  
  subject { FactoryBot.build(:similar_email) }
  
  describe "validations" do
    it { should belong_to :first_user }
    it { should belong_to :second_user }

    it "accepts valid attributes" do
      expect(subject).to be_valid
    end
  end

end
