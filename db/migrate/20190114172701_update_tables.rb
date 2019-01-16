class UpdateTables < ActiveRecord::Migration[5.2]
  def change
  	execute("ALTER TABLE status_codes MODIFY COLUMN id BIT(2) NOT NULL")
  	execute("ALTER TABLE questions MODIFY COLUMN status_codes_id BIT(2)")
  	execute("ALTER TABLE questions ADD FOREIGN KEY(status_codes_id) REFERENCES status_codes(id)")
  	execute("ALTER TABLE answers MODIFY COLUMN status BIT(1) NOT NULL")
  	execute("ALTER TABLE site_settings MODIFY COLUMN id INT NOT NULL AUTO_INCREMENT")
  	execute("ALTER TABLE question_accesses MODIFY COLUMN answer_access BIT(1) NOT NULL, MODIFY COLUMN vote_access BIT(1) NOT NULL")
  	execute("INSERT INTO status_codes VALUES(B'00','opened',NOW(),NOW()),(B'01','accepted',NOW(),NOW()),(B'10','closed',NOW(),NOW()),(B'11','deleted',NOW(),NOW())")
  end		
end