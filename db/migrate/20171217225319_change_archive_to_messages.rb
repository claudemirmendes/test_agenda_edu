class ChangeArchiveToMessages < ActiveRecord::Migration[5.0]
  def change
    change_column :messages, :archive, :boolean, :default => false
  end
end
