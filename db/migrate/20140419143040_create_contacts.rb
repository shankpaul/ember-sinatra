class CreateContacts < ActiveRecord::Migration
 def up
    create_table :contacts do |t|
      t.string :name
      t.string :address
      t.string :email
      t.string :phone
      t.text :image
      t.timestamps
    end    
  end
 
  def down
    drop_table :contacts
  end
end
