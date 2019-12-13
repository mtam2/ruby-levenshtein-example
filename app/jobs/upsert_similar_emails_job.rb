class UpsertSimilarEmailsJob
  include Sidekiq::Worker
  sidekiq_options queue: :high, retry: 0, backtrace: true

  def perform
    query = <<-SQL
      SELECT u1.email email_1, u2.email email_2
      FROM users u1
      JOIN users u2 ON u1.email != u2.email
      LEFT JOIN similar_emails se ON se.email_1 = u1.email AND se.email_2 = u2.email
      WHERE se.id IS NULL
      OR se.levenshtein_distance iS NULL
      OR se.damerau_levenshtein_distance iS NULL;
    SQL
    missing_matches = ActiveRecord::Base.connection.execute(query)
    missing_matches.each do |match|
      UpsertOneSimilarEmailJob.perform_async(match["email_1"], match["email_2"])
    end
  end
end
