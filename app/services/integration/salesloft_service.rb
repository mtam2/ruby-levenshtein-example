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


  end
end
