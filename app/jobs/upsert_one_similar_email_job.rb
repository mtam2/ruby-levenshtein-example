class UpsertOneSimilarEmailJob
  include Sidekiq::Worker
  sidekiq_options queue: :high, retry: 0, backtrace: true

  def perform(email_1, email_2)
    dl = DamerauLevenshtein
    se = SimilarEmail.new(
      email_1: email_1,
      email_2: email_2,
    )
    se.update(
      levenshtein_distance: dl.distance(email_1, email_2, 0),
      damerau_levenshtein_distance: dl.distance(email_1, email_2),
    )
  end
end
