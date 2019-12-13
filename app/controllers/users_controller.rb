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
    @characters = Integration::SalesloftService.new.calculate_frequency
  end

  def possible_duplicate_emails
    @distances = Integration::SalesloftService.new.possible_duplicate_emails
  end

  def refresh_data
    Integration::UpsertSalesloftUsersJob.new.perform
    redirect_to action: :index
  end
end
