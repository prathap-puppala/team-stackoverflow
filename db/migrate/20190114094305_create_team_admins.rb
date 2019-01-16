class CreateTeamAdmins < ActiveRecord::Migration[5.2]
  def change
    create_table :team_admins do |t|
      t.bigint :team_id
      t.bigint :user_id

      t.timestamps
    end
    add_foreign_key :team_admins, :teams
    add_foreign_key :team_admins, :users
  end
end
