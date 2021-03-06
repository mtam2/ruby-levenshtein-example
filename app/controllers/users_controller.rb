class UsersController < ApplicationController
  def index
    @users = User.all.as_json(
      only: [
        :first_name,
        :last_name,
        :display_name,
        :email,
        :title,
      ]
    )
  end

  def email_character_frequency
    @characters = User.calculate_frequency
  end

  def possible_duplicate_emails
    @distances = User.possible_duplicate_emails(quick_calc: params[:quick_calc].blank?)
  end

  def refresh_data
    begin
      Integration::UpsertSalesloftUsersJob.new.perform
    rescue => e
      puts e
      # TODO: Implement error notification
    end
    redirect_to action: :index
  end
end
