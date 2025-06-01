class AdSerializer < ActiveModel::Serializer
  attributes :id, :name, :status, :ad_type, :final_url, :headline1, :headline2, :description

  include Rails.application.routes.url_helpers

  attribute :image_url do
    rails_blob_url(object.image, only_path: true) if object.image.attached?
  end

  attribute :video_url do
    rails_blob_url(object.video, only_path: true) if object.video.attached?
  end
end
