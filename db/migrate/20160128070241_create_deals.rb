class CreateDeals < ActiveRecord::Migration
  def change
    create_table :deals do |t|
      t.string :title
      t.text :description
      t.decimal :price, precision: 8, scale: 2
      t.decimal :discounted_price, precision: 8, scale: 2
      t.integer :quantity, default: 0
      t.date :publish_date
      t.boolean :publishable, null: false, default: false
      t.boolean :live, null: false, default: false

      t.timestamps null: false
    end
  end
end
