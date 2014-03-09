class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :short
      t.text :long
    end
  end
end
