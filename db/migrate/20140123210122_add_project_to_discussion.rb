class AddProjectToDiscussion < ActiveRecord::Migration
  def change
    add_reference :discussions, :projects, index: true
  end
end
