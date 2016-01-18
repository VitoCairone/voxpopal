class CreateSpeakerHistories < ActiveRecord::Migration
  def change
    create_table :speaker_histories do |t|
      t.references :speaker, index: true, foreign_key: true
      t.references :issue_spare_1, issue: true, index: true, foreign_key: true
      t.references :issue_spare_2, issue: true, index: true, foreign_key: true
      t.references :issue_next, issue: true, index: true, foreign_key: true
      t.references :issue_prev, issue: true, index: true, foreign_key: true
      t.integer :issue_prev_position

      t.timestamps null: false
    end
  end
end
