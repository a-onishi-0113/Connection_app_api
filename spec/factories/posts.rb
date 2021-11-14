FactoryBot.define do
  factory :post do
    title { "MyString" }
    content { "MyText" }
    latitude { "MyString" }
    longitude { "MyString" }
    formmated_address { "MyString" }
    user { nil }
  end
end
