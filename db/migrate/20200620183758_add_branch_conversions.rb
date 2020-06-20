class AddBranchConversions < ActiveRecord::Migration[6.0]
  def change
    create_table :branch_conversions, id: :uuid do |t|
      t.column :user_id, :uuid, null: false
      t.column :status, :string, null: false
      t.column :repo_full_name, :string, null: false
      t.column :old_default_branch_name, :string, null: false
      t.column :new_default_branch_name, :string, null: false
      t.index :status
      t.foreign_key :users
      t.index :user_id
    end
  end
end
