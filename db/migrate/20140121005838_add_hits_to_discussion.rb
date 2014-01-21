class AddHitsToDiscussion < ActiveRecord::Migration
  def change
    add_column :discussions, :hits, :integer, default:0
  end
end
