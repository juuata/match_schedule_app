class CreateFavorites < ActiveRecord::Migration[7.1]
  def change
    create_table :favorites do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :fixture_id, null: false

      t.timestamps
    end

    add_index :favorites, [:user_id, :fixture_id], unique: true
  end
end
