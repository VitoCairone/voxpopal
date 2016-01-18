class AddSpeakerHistoryToSpeaker < ActiveRecord::Migration
  def change
    add_reference :speakers, :speaker_history, index: true, foreign_key: true
  end
end
