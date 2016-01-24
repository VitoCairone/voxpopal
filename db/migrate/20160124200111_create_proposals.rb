class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :code
      t.references :speaker, index: true, foreign_key: true
      t.text :text
      t.integer :upvotes
      t.integer :downvotes
      t.integer :boost

      t.timestamps null: false
    end
  end
end
