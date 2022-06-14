class CreateMembers < ActiveRecord::Migration[7.0]
  def change
    create_table :members, id: :uuid do |t|
      t.uuid :user_id, null: false, foreign_key: true
      t.date :subscription
      t.boolean :is_active
      t.jsonb :settings

      t.timestamps
    end
  end
end
