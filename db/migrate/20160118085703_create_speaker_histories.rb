class CreateSpeakerHistories < ActiveRecord::Migration
  def change
    create_table :speaker_histories do |t|
      t.references :speaker, index: true, foreign_key: true
      t.references :issue_spare_1, references: :issues
      t.references :issue_spare_2, references: :issues
      t.references :issue_spare_3, references: :issues
      t.references :issue_next, references: :issues
      t.references :issue_prev, referenes: :issues
      t.integer :issue_prev_position

      t.timestamps null: false
    end
  end
end
