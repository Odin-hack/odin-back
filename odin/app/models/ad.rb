class Ad < ApplicationRecord
  belongs_to :ad_group

  has_one_attached :image
  has_one_attached :video

  enum status: { paused: 0, enabled: 1, removed: 2 }
  enum ad_type: { text: 0, image: 1, video: 2 }

  validates :name, :status, :ad_type, :final_url, presence: true

  validates :headline1, :headline2, presence: true, if: -> { ad_type == "text" }

  def image_data=(base64)
    return if base64.blank?

    content_type = base64[%r{data:(.*?);base64}, 1]
    encoded_image = base64.sub(%r{^data:.*;base64,}, "")

    decoded_data = Base64.decode64(encoded_image)
    filename = "upload-#{SecureRandom.hex}.#{content_type.split('/').last}"

    self.image.attach(io: StringIO.new(decoded_data), filename: filename, content_type: content_type)
  end
end
