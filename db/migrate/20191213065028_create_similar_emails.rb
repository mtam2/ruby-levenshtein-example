class CreateSimilarEmails < ActiveRecord::Migration[6.0]
  def change
    create_table :similar_emails do |t|
      t.text :email_1, null: false
      t.text :email_2, null: false
      t.integer :levenshtein_distance
      t.integer :damerau_levenshtein_distance

      t.timestamps
    end
    add_index :similar_emails, [:email_1, :email_2], unique: true
    add_foreign_key :similar_emails, :users, column: :email_1, primary_key: :email
    add_foreign_key :similar_emails, :users, column: :email_2, primary_key: :email
  end
end
