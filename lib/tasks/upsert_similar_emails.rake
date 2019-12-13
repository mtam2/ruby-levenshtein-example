namespace :upsert_similar_emails do
  task :trigger => :environment do
    trigger_job
  end

  def trigger_job
    Integration::UpsertSalesloftUsersJob.new.perform
    UpsertSimilarEmailsJob.new.perform
  end
end
