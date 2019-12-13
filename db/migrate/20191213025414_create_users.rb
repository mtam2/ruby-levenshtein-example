class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.text :first_name
      t.text :last_name
      t.text :display_name
      t.text :email, null: false
      t.text :title
      t.jsonb :ss_data, null: false, default: {}

      t.timestamps
    end
    add_index :users, [:email], unique: true
  end
end
