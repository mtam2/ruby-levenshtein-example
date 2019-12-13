module Integration
  class SalesloftApi
    include HTTParty
    base_uri ENV["API_ENDPOINT"]
  
    attr_accessor :headers

    def initialize
      @headers = {
        "Authorization" => "Bearer #{ENV["API_KEY"]}"
      }
    end

    def get_people
      path = "/v2/people.json"
      params = {
        per_page: 100,
      }
      response = self.class.send(
        :get,
        path,
        headers: headers,
        query: params,
        timeout: 300,
      )
      if response.code == 200
        JSON.parse(response.body)
      else
        response
      end
    end

  end
end
