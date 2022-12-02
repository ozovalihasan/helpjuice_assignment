FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 3, random_words_to_add: 4) }
    body { Faker::Quote.matz + Search.all.sample.keywords + Faker::Quote.famous_last_words }
  end
end

FactoryBot.define do
  factory :mock_article, class: "Article" do
    sequence(:title) { |n| "title_#{n}" }
    sequence(:body) { |n| "body_#{n} keywords_#{n}" }
  end
end