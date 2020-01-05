require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe "#index" do
    it "should return JSON body of user data" do
      get :index
      expect(response).to render_template("index")
      expect(response.status).to eq(200)
    end
  end

  describe "#email_character_frequency" do
    it "should return JSON body of frequency data" do
      get :email_character_frequency
      expect(response).to render_template("email_character_frequency")
      expect(response.status).to eq(200)
    end
  end

  describe "#possible_duplicate_emails" do
    it "should return JSON body of duplicate email data" do
      get :possible_duplicate_emails
      expect(response).to render_template("possible_duplicate_emails")
      expect(response.status).to eq(200)
    end
  end

  describe "#refresh_data" do
    subject { post :refresh_data }
    it "should return JSON body of user data" do
      expect(subject).to redirect_to(:action => :index)
    end
  end
end
