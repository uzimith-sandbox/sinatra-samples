class CreateCounts < ActiveRecord::Migration
  def change
    create_table :counts do |t|
      t.integer :number
      t.timestamps
    end
  end
end
