class RemovePasswordFromSpeakers < ActiveRecord::Migration
  def change
    remove_column :speakers, :password, :string
  end
end
