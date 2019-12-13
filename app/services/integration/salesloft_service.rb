module Integration
  class SalesloftService
    attr_accessor :api

    def initialize
      @api = Integration::SalesloftApi.new
    end

    def upsert_users
      response = api.get_people
      users = []
      response["data"].each do |raw_user|
        user = {
          first_name:   raw_user["first_name"],
          last_name:    raw_user["last_name"],
          display_name: raw_user["display_name"],
          email:        raw_user["email_address"],
          title:        raw_user["title"],
          ss_data:      raw_user,
          created_at:   DateTime.now,
          updated_at:   DateTime.now,
        }
        users << user
      end
      User.upsert_all(users, unique_by: :email)
    end

    def calculate_frequency
      query = <<-SQL
        SELECT
          regexp_split_to_table(email, '') chars,
          count(*)
        FROM users
        GROUP BY chars
        ORDER 
        BY count(*) DESC;
      SQL
      frequencies = ActiveRecord::Base.connection.execute(query).as_json
    end

  end
end
