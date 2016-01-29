class Order < ActiveRecord::Base

  before_validation :check_deal_availability, :set_discount, :set_sale_price, on: :create, if: ->{ user && deal }
  after_commit :update_deal, on: :create

  belongs_to :user, counter_cache: true
  belongs_to :deal

  validates :user, :deal, presence: true
  validates :discount, :sale_price, presence: true, if: ->{ user && deal }
  validates :discount, numericality: {
                                        greater_than_or_equal_to: 0,
                                        less_than_or_equal_to: 5
                                     }, allow_blank: true
  validates :deal, uniqueness: { scope: :user, message: 'can only be purchased once!' }

  private

    def update_deal
      self.deal.decrement!(:quantity)
    end

    def set_discount
      self.discount ||= user.orders_count > 5 ? 5 : user.orders_count
    end

    def set_sale_price
      self.sale_price ||= deal.discounted_price - deal.discounted_price * discount / 100
    end

    def check_deal_availability
      unless deal.live && deal.publishable && deal.quantity > 0
        errors.add(:base, 'Deal cannot be purchased!')
        false
      end
    end
end