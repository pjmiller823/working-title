class AddDuebyToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :due_by, :date
  end
end
