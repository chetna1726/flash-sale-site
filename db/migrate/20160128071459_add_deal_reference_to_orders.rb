class AddDealReferenceToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :deal, index: true, foreign_key: true
  end
end
