class CreateSubmissions < ActiveRecord::Migration[5.0]
  def change
    create_table :submissions do |t|
      t.text :intro
      t.text :body

      t.timestamps
    end
  end
end
