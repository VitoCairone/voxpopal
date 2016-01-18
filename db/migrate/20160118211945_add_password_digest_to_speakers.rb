class AddPasswordDigestToSpeakers < ActiveRecord::Migration
  def change
    add_column :speakers, :password_digest, :string
  end
end
