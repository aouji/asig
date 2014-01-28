class RemoveCountFromVotes < ActiveRecord::Migration
  def change
    remove_column :votes, :count, :integer
  end
end
