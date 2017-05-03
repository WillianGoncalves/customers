class Customer < ApplicationRecord
  # inverse_of evita o erro "customer não definido" em address/phones
  has_one :address, dependent: :destroy, inverse_of: :customer
  has_many :phones, dependent: :destroy, inverse_of: :customer

  enum gender: [:male, :female]
  
  validates :first_name, :last_name, :avatar, :address, :phones, presence: true

  # faz a validação de address e phones
  validates_associated :address, :phones

  accepts_nested_attributes_for :address, :phones
end
