class AddGuestAndAdminToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :guest, :boolean, default: true
    add_column :speakers, :admin, :boolean, default: false
  end
end
