class CreateWeeks < ActiveRecord::Migration[5.1]
  def change
    create_table :weeks do |t|
      t.references :user
      t.date :start
      t.date :end

      t.timestamps
    end
  end
end
