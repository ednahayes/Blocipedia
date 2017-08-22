class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.references :user, foreign_key: true
      t.references :wiki, foreign_key: true

      t.timestamps
    end
    add_index :wiki, :id, unique: true
    add_index :collaborators, :user_id, unique: true
    add_index :user, :id, unique: true
  end
end
