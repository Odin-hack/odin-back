class AdGroup::CreateService < ApplicationService
  def call(params)
    ad_group = AdGroup.new(params)

    if ad_group.save
    success(ad_group)
    else
    failure(ad_group.errors.full_messages.to_sentence)
    end
  end
end
