class AddIndexToSpeakers < ActiveRecord::Migration
  def change
    add_index :speakers, :session_token
    add_index :speakers, :email
    add_index :speakers, :codename, unique: true
  end
end
