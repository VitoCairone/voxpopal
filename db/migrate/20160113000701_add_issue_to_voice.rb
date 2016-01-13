class AddIssueToVoice < ActiveRecord::Migration
  def change
    add_reference :voices, :issue, index: true, foreign_key: true
  end
end
