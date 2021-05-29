class Transaction < ApplicationRecord
  before_create :create_uuid
  acts_as_paranoid
  TYPE = %w[deposit withdraw].freeze
  belongs_to :account
  enum transation_type: TYPE

  validates :amount,           presence: true
  validates :transaction_type, presence: true
  delegate :bank, to: :account, prefix: true


  def create_uuid
    loop do
      self.uuid = SecureRandom.hex(16)
      break unless self.class.exists?(:uuid => uuid)
    end
  end
end
