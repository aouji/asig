class AddHitsToProject < ActiveRecord::Migration
  def change
    add_column :projects, :hits, :integer, default:0
  end
end
