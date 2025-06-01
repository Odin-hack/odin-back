class Ad < ApplicationRecord
  belongs_to :ad_group

  has_one_attached :image
  has_one_attached :video

  enum status: { paused: 0, enabled: 1, removed: 2 }
  enum ad_type: { text: 0, image: 1, video: 2 }

  validates :name, :status, :ad_type, :final_url, presence: true

  validates :headline1, :headline2, presence: true, if: -> { ad_type == "text" }
end
