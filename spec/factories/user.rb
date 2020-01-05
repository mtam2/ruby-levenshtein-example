FactoryBot.define do
  factory :user_1, class: User do
    email { "test@google.com" }
  end

  factory :user_2, class: User do
    email { "tester@google.com" }
  end
end
