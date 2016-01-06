class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :codename
      t.references :speaker, index: true, foreign_key: true
      t.text :text

      t.timestamps null: false
    end
  end
end
