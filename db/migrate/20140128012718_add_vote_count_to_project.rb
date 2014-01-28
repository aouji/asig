class AddVoteCountToProject < ActiveRecord::Migration
  def change
    add_column :projects, :vote_count, :integer, default: 0
  end
end
