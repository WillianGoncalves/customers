class Address < ApplicationRecord
  belongs_to :customer

  validates :street, :city, :state, :country, presence: true
end
