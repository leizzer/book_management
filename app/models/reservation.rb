class Reservation < ApplicationRecord
  belongs_to :book

  validate :book_is_free, on: [:create]

  before_validation :set_expiration_date
  after_create :update_book_status

  scope :active_for, ->(book_id) {
    where(book_id: book_id)
      .where('expiration_date > ?', DateTime.now)
  }

  private

  def set_expiration_date
    self.expiration_date = DateTime.now + 7.days
  end

  def book_is_free
    if Reservation.active_for(self.book_id).exists?
      errors.add(:book, "reserved already reserved")
    end
  end

  # This approach is bad it doesn't take into account when
  # the reservation expires
  def update_book_status
    self.book.reserved!
  end

end
