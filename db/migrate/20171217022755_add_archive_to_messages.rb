class AddArchiveToMessages < ActiveRecord::Migration[5.0]
  def change
    add_column :messages, :archive, :boolean
  end
end
