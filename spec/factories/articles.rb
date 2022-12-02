FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 3) + Search.all.sample.keywords + Faker::Lorem.sentence(word_count: 3) }
    body { Faker::Quote.matz }
  end
end

FactoryBot.define do
  factory :mock_article, class: "Article" do
    sequence(:title) { |n| "title_#{n} keywords_#{n}" }
    sequence(:body) { |n| "body_#{n}" }
  end
end