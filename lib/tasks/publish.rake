namespace :deal do
  desc 'Publish a new deal'
  task publish: :environment do
    Deal.unpublish_old_deal
    new_deal = Deal.find_by(publishable: true, publish_date: Date.current)
    new_deal.try(:make_live)
  end
end