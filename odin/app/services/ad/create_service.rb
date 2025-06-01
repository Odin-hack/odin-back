class Ad::CreateService < ApplicationService
	def call(params)
		ad = Ad.new(params)

		if ad.save
			success(ad)
		else
			failure(ad.errors.full_messages.to_sentence)
		end
	end
end
