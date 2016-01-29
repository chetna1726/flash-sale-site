class Deal < ActiveRecord::Base

  before_destroy :authenticate_for_destroy
  before_save :authenticate_for_publish

  has_many :orders, inverse_of: :deal, dependent: :restrict_with_error
  has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }

  validates :title, presence: true

  with_options if: ->{ publishable } do |deal|
    deal.validates :description, :price, :discounted_price, :quantity, :publish_date, presence: true
    deal.validates :publish_date, uniqueness: true, allow_blank: true, if: -> { live }
    deal.validates :quantity, numericality: { greater_than_or_equal_to: 0 }, allow_blank: true
    deal.validates :price, numericality: {
                                    greater_than: :discounted_price,
                                    message: 'Price must be greater than Discounted Price.'
                                  }, if: ->{ price? && discounted_price? }
  end

  validates :publishable, acceptance: { accept: true, message: 'required to publish!' }, if: -> { live }

  private

    def authenticate_for_destroy
      if live
        errors.add(:base, 'Cannot delete a live deal!')
        false
      end
    end

    def authenticate_for_publish
      if live
        if Deal.where(live: true).many? || publish_date != Date.current
          errors.add(:base, 'Cannot publish deal!')
          false
        end
      end
    end

end