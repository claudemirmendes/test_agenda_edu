class ChangeReadToMessages < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :read, :boolean, :default => false
  end
end
