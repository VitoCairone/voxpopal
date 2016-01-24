class AddVerificationToSpeakers < ActiveRecord::Migration
  def change
    add_reference :speakers, :verification, index: true, foreign_key: true
  end
end
