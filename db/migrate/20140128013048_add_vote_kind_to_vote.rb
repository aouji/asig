class AddVoteKindToVote < ActiveRecord::Migration
  def change
    add_column :votes, :vote_kind, :string
  end
end
