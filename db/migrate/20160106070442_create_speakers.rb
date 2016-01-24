class CreateSpeakers < ActiveRecord::Migration
  def change
    create_table :speakers do |t|
      t.string :codename
      t.string :name
      t.string :email
      t.string :password_digest
      t.string :starsign
      t.string :birth_month
      t.integer :birth_year
      t.integer :level
      t.string :session_token, limit: 64
      t.string :recall_token, limit: 64
      t.boolean :logged_in
      t.timestamp :last_action

      t.timestamps null: false
    end
  end
end
