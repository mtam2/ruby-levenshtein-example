FactoryBot.define do
  factory :similar_email, class: SimilarEmail do
    association :first_user, factory: :user_1
    association :second_user, factory: :user_2
  end
end
