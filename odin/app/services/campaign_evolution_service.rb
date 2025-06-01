class CampaignEvolutionService
  VARIANTS = [
    ->(headline) { "#{headline} - Limited Time!" },
    ->(headline) { "🔥 #{headline} 🔥" },
    ->(headline) { "#{headline} | Official Site" },
    ->(headline) { "#{headline} - Try Now" }
  ]

  def self.call
    Ad.includes(:ad_group).find_each do |ad|
      new(ad).evolve_if_needed
    end
  end

  def initialize(ad)
    @ad = ad
  end

  def evolve_if_needed
    return unless eligible_for_evolution?

    new_headline = generate_variant(@ad.headline1)
    return if new_headline == @ad.headline1

    AdHistory.create!(
      ad: @ad,
      field_changed: "headline1",
      old_value: @ad.headline1,
      new_value: new_headline
    )

    @ad.update!(
      headline1: new_headline,
      last_evolved_at: Time.current
    )
  end

  private

  def eligible_for_evolution?
    return false if @ad.headline1.blank?
    return true if @ad.last_evolved_at.nil?

    @ad.last_evolved_at <= 5.days.ago
  end

  def generate_variant(original)
    VARIANTS.sample.call(original)
  end
end
