class AddAvailableFromAndAvailableToAndOwnerIdToFlats < ActiveRecord::Migration[7.1]
  def change
    add_column :flats, :available_from, :date
    add_column :flats, :available_to, :date
    add_reference :flats, :owner, foreign_key: { to_table: :users }
  end
end
