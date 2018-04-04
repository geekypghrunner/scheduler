class CreateDays < ActiveRecord::Migration[5.1]
  def change
    create_table :days do |t|
      t.references :user, foreign_key: true
      t.references :week, foreign_key: true
      t.string :date

      t.timestamps
    end
  end
end
