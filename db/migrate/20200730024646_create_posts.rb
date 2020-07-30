class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :description
      t.belongs_to :employee
      
      t.timestamps
    end
  end
end
