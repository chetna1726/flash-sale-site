namespace :deal do
  desc 'Publish a new deal'
  task publish: :environment do
    Deal.unpublish_old_deal
    new_deal = Deal.publishable_deals_for_today.first
    new_deal.try(:make_live)
  end
end