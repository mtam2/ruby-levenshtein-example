module Integration
  class SalesloftService
    attr_accessor :api

    def initialize
      @api = Integration::SalesloftApi.new
    end

    def upsert_users
      response = api.get_people
      current_page = response.dig("metadata", "paging", "current_page").to_i
      raise "Invalid API call. #{response.to_s}" if response.class != Hash
      while current_page < (response.dig("metadata", "paging", "total_pages").to_i + 1)
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
        current_page += 1
        response = api.get_people(page: current_page)
      end
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

    def possible_duplicate_emails
      postgres_levenshtein_query = <<-SQL
        SELECT u1.email email_1, u2.email email_2, levenshtein(u1.email, u2.email) levenshtein_distance
        FROM users u1
        JOIN users u2 ON u1.email != u2.email
        WHERE levenshtein(u1.email, u2.email) <= 5
        ORDER BY u1.email, levenshtein_distance ASC;
      SQL
      {
        levenshtein_distances: ActiveRecord::Base.connection.execute(postgres_levenshtein_query).as_json,
      }
    end

  end
end
