namespace :deal do
  desc 'Publish a new deal'
  task publish: :environment do
    old_deal = Deal.find_by(live: true)
    new_deal = Deal.find_by(publishable: true, publish_date: Date.current)
    old_deal.update_column(:live, false) if old_deal
    new_deal.update_column(:live, true) if new_deal
  end
end