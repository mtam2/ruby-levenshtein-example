class SimilarEmail < ApplicationRecord
  belongs_to :first_user, class_name: "User", foreign_key: :email_1, primary_key: :email
  belongs_to :second_user, class_name: "User", foreign_key: :email_2, primary_key: :email
end
