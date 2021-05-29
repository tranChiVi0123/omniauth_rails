class Account < ApplicationRecord
  acts_as_paranoid
  belongs_to :user
  has_many :transactions, dependent: :destroy

  KIND_OF_BANK = %w(BIDV Vietinbank Vietcombank Agribank).freeze

  enum bank: KIND_OF_BANK

  validates :name, presence: true
  validates :bank, presence: true, inclusion: {in: KIND_OF_BANK}
end
