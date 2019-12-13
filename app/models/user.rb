class User < ApplicationRecord
  validates_presence_of :email

  has_many :similar_emails, class_name: 'SimilarEmail', foreign_key: 'email_1', primary_key: 'email'

  def self.calculate_frequency
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

  def self.possible_duplicate_emails(quick_calc: true)
    deprecated_postgres_levenshtein_query = <<-SQL
      SELECT u1.email email_1, u2.email email_2, levenshtein(u1.email, u2.email) levenshtein_distance
      FROM users u1
      JOIN users u2 ON u1.email != u2.email
      WHERE levenshtein(u1.email, u2.email) <= 5
      ORDER BY u1.email, levenshtein_distance ASC;
    SQL

    static_query = <<-SQL
      SELECT
        email_1,
        email_2,
        levenshtein_distance,
        damerau_levenshtein_distance
      FROM
        similar_emails
      WHERE
        levenshtein_distance <= 5
        OR damerau_levenshtein_distance <= 5
    SQL

    query = quick_calc ? deprecated_postgres_levenshtein_query : static_query
    {
      levenshtein_distances: ActiveRecord::Base.connection.execute(query).as_json,
    }
  end

end
