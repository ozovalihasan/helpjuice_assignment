class Article < ApplicationRecord
  scope :search, ->(keywords) { where('body LIKE ?', "%#{keywords}%") }
end
