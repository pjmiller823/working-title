class AddCreatedbyidToComments < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :created_by_id, :integer
  end
end
