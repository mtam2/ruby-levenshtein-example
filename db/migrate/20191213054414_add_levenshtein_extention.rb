class AddLevenshteinExtention < ActiveRecord::Migration[6.0]
  def change
    command = "CREATE EXTENSION fuzzystrmatch;"
    ActiveRecord::Base.connection.execute(command)
  end
end
