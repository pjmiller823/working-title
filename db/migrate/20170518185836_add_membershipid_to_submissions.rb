class AddMembershipidToSubmissions < ActiveRecord::Migration[5.0]
  def change
    add_column :submissions, :membership_id, :integer
  end
end
