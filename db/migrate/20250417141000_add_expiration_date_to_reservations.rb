class AddExpirationDateToReservations < ActiveRecord::Migration[8.0]
  def change
    add_column :reservations, :expiration_date, :date, null: false
  end
end
