class CreateBankAccounts < ActiveRecord::Migration[5.1]
  def change
    create_table :bank_accounts do |t|
      t.belongs_to :user, foreign_key: true
      t.float :amount, null: false, default: 0
      t.boolean :active, null: false, default: true
      t.text :ledger
      t.string :institution, null: false
      t.text :description

      t.timestamps
    end
  end
end
