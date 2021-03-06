class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :count
      t.references :user, index: true
      t.references :project, index: true

      t.timestamps
    end
  end
end
