class CreateMessages < ActiveRecord::Migration[5.0]
  def change
    create_table :messages do |t|
      t.text :content
      t.string :author
      t.integer :ctime
      t.string :ip

      # t.timestamps
    end
  end
end
