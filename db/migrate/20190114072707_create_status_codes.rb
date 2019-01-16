class CreateStatusCodes < ActiveRecord::Migration[5.2]
  def change
    create_table :status_codes do |t|
      t.string :name

      t.timestamps
    end
    #change_column :status_codes, :id, :tinyint, null: false, unique: true
  end
end
