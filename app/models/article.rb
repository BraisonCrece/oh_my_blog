class Article < ApplicationRecord
  include ArticleImagesHandler

  belongs_to :user
  has_many :article_images, dependent: :destroy

  validates :title, presence: true
  validates :content, presence: true
end
