FactoryBot.define do
  factory :post_comment do
    comment { "MyText" }
    user { nil }
    post { nil }
  end
end
