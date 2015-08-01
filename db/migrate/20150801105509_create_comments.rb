class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.text :desc
      t.references :article, index: true
      t.references :user, index: true
      t.string :ancestry

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
