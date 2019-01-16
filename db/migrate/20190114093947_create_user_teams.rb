class CreateUserTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :user_teams do |t|
      t.bigint :user_id
      t.bigint :team_id

      t.timestamps

    end

    add_foreign_key :user_teams, :users
    add_foreign_key :user_teams, :teams
  end
end
