class AddUserTypeToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :user_type, :integer,default: 0
  end
end
