class AddIssueSpare3ToSpeakerHistories < ActiveRecord::Migration
  def change
    add_reference :speaker_histories, :issue_spare_3, issue: true, index: true, foreign_key: true
  end
end
