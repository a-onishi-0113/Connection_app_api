class RenameFommatedAddressColumnToFormattedAddress < ActiveRecord::Migration[6.0]
  def change
    rename_column :posts, :formmated_address, :formatted_address
  end
end
