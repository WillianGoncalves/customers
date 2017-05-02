class Customer < ApplicationRecord
  has_one :address
  has_many :phones

  enum gender: [:male, :female]

  validates :first_name, :last_name, :avatar, presence: true

  accepts_nested_attributes_for :address, :phones
end
