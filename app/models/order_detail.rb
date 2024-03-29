class OrderDetail < ApplicationRecord
  enum making_status: { 制作不可: 0, 制作待ち: 1, 製作中: 2, 制作完了: 3 }

  belongs_to :item
  belongs_to :order

  def subtotal_price
    item.price * quantity
  end
end
