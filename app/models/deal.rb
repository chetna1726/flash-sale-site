class Deal < ActiveRecord::Base

  before_destroy :check_destroyablity
  before_save :check_publishability

  has_many :orders, inverse_of: :deal, dependent: :restrict_with_error
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }

  validates :title, presence: true

  with_options if: ->{ publishable } do |deal|
    deal.validates :description, :price, :discounted_price, :quantity, :publish_date, presence: true
    deal.validates :quantity, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
    deal.validates :price, numericality: {
                                    greater_than: :discounted_price,
                                    message: 'Price must be greater than Discounted Price.'
                                  }, if: ->{ price? && discounted_price? }
  end

  with_options if: ->{ live } do |deal|
    validates :publishable, acceptance: { accept: true, message: 'required to publish!' }, if: -> { live }
    validates :publish_date, uniqueness: true, allow_blank: true, if: -> { live }
  end

  scope :live_deal, ->{ where(live: true) }

  def make_live
    self.update_column(:live, true) if self
  end

  private

    def check_destroyablity
      if live
        errors.add(:base, 'Cannot delete a live deal!')
        false
      end
    end

    def check_publishability
      if live
        if Deal.live_deal.many? || publish_date != Date.current
          errors.add(:base, 'Cannot publish deal!')
          false
        end
      end
    end

    def self.unpublish_old_deal
      old_deal = Deal.live_deal.first
      old_deal.update_column(:live, false) if old_deal
    end


end