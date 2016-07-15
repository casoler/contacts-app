class AddMiddleNameToContacts < ActiveRecord::Migration
  def change
    add_column :contacts, :middle_name, :string, null: false, default: ''
  end
end
