class PrivateArticle < ApplicationRecord
  validates :title, presence: true, length: {minimum: 3, maximum: 100}
  validates :description, presence: true, length: {minimum: 10, maximum: 300}
  belongs_to :user
end