class CreateVoices < ActiveRecord::Migration
  def change
    create_table :voices do |t|
      t.references :speaker, index: true, foreign_key: true
      t.references :choice, index: true, foreign_key: true
      t.integer :level

      t.timestamps null: false
    end
  end
end
