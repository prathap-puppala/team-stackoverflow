class CreateSiteSettings < ActiveRecord::Migration[5.2]
  def change
    create_table :site_settings do |t|
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
