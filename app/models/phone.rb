class Phone < ApplicationRecord
  belongs_to :customer

  validates :number, presence: true
end
