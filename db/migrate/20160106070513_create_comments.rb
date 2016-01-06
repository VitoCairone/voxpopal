class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.references :speaker, index: true, foreign_key: true
      t.references :parent, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
