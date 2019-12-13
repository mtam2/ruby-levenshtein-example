module Integration
  class UpsertSalesloftUsersJob
    include Sidekiq::Worker
    sidekiq_options queue: :high, retry: 0, backtrace: true

    def perform
      response = Integration::SalesloftService.new.upsert_users
    end
  end
end
