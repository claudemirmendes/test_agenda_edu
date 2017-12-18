class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.boolean :send
      t.boolean :read
      t.datetime :date_send
      t.datetime :date_read
      t.text :text
      t.integer :user_id
      t.integer :user_send_id
      t.integer :user_received_id

      t.timestamps
    end
  end
end
