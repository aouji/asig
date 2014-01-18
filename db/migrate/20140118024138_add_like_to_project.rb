class AddLikeToProject < ActiveRecord::Migration
  def change
    add_column :projects, :like, :integer,default: 0
  end
end
