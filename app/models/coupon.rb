class Coupon < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }

  enum coupon_type: [:percent, :number]
  enum coupon_target_type: [:individual, :all_users]

  has_and_belongs_to_many :users

  scope :get_coupon_for_all, -> { where coupon_target_type: "all_users" }
  scope :get_coupon_for_user, ->(user_id){ where coupon_target_id: user_id }
end