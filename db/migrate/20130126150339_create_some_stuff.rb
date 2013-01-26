class CreateSomeStuff < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name
    end

    create_table :invoices do |t|
      t.string :name
      t.boolean :paid
      t.float :amount
      t.references :client
    end
  end
end
