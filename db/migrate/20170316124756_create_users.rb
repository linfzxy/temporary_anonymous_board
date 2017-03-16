class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :verifyword
      t.string :ip
      t.time :activitydate

      # t.timestamps
    end
  end
end
