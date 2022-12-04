FactoryBot.define do
  factory :search do
    keywords { Faker::Lorem.sentence(word_count: 1, supplemental: false, random_words_to_add: 3) }
  end
end

FactoryBot.define do
  factory :mock_search, class: "Search" do
    sequence(:keywords) { |n| "keywords_#{n}" }
  end
end