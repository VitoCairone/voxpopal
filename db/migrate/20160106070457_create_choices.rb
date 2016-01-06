class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.references :issue, index: true, foreign_key: true
      t.references :speaker, index: true, foreign_key: true
      t.text :text
      t.integer :voice_tally_1
      t.integer :voice_tally_2
      t.integer :voice_tally_3
      t.integer :current_rank

      t.timestamps null: false
    end
  end
end
