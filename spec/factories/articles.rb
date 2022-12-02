FactoryBot.define do
  factory :article do
    title { Faker::Lorem.sentence(word_count: 3, supplemental: false, random_words_to_add: 4) }
    body { Faker::Lorem.paragraph }
  end
end

FactoryBot.define do
  factory :mock_article, class: "Article" do
    sequence(:title) { |n| "title_#{n} keywords_#{n}" }
    sequence(:body) { |n| "body_#{n}" }
  end
end