class Book < ApplicationRecord
  has_many :reservations

  enum :status, [:free, :reserved]

  def reserve!(email)
    transaction do
      self.reservations.create email: email
      self.reserved!
    end
  end
end
