class Order < ApplicationRecord
 enum payment_method: { credit_card: 0, transfer: 1 }
 enum status: { 入金待ち: 0, 入金確認: 2, 制作中: 3, 発送準備中: 4 }

  has_many :order_details, dependent: :destroy

  belongs_to :customer

  def total_price
    order_details.to_a.sum { |item| item.subtotal_price }
  end

  def subtotal
    order_details.collect { |order_detail| order_detail.valid? ? (order_detail.price * order_detail.amount) : 0 }.sum
  end

end
