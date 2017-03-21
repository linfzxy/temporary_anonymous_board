class CreateIptables < ActiveRecord::Migration[5.0]
  def change
    create_table :iptables do |t|
      t.string :ip
      t.integer :counter
      t.integer :lowerbounder
      t.boolean :banned

      # t.timestamps
    end
  end
end
