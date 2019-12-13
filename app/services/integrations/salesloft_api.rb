module Integrations
  class SalesloftAPI
    include HTTParty
    base_uri ENV["API_ENDPOINT"]
  
    def initialize
    end

  end
end
