    class Vote < ActiveRecord::Migration[5.0]
      belongs_to :question
      belongs_to :answer
      belongs_to :votable, :polymorphic =>true
      validates :votable_type, :votable_id, :presence => true

      method: POST 
      body: {"votable_id":"1","votable_type":"Post","user_id":"1"}
      content-type: application/json
      response: {"status":200,"message":"upvoted successfully."}

    end
