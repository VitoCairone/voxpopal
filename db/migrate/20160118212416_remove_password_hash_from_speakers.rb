class RemovePasswordHashFromSpeakers < ActiveRecord::Migration
  def change
    remove_column :speakers, :password_hash, :string
  end
end
