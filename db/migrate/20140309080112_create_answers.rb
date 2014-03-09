class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :party_id
      t.integer :question_id
      t.integer :answer, default: 0, null: false
    end
  end
end
