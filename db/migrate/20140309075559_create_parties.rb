class CreateParties < ActiveRecord::Migration
  def change
    create_table :parties do |t|
      t.string :name
    end
  end
end
