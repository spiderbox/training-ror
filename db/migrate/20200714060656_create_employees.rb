class CreateEmployees < ActiveRecord::Migration[6.0]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :password
      t.datetime :dob

      t.timestamps
    end
  end
end
