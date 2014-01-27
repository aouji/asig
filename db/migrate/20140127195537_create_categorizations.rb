class CreateCategorizations < ActiveRecord::Migration
  def change
    create_table :categorizations do |t|
      t.references :project, index: true
      t.references :category, index: true

      t.timestamps
    end
  end
end
