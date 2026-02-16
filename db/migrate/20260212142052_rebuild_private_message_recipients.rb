class RebuildPrivateMessageRecipients < ActiveRecord::Migration[7.1]
  def change
    drop_table :private_message_recipients, if_exists: true

    create_table :private_message_recipients do |t|
      t.references :private_message, null: false, foreign_key: true
      t.references :recipient, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
