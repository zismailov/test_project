class CreateBars < ActiveRecord::Migration[7.0]
  def change
    create_table :bars do |t|
      t.string :name, null: false
      t.text :description
      t.references :foo, null: false, foreign_key: true, on_delete: :cascade

      t.timestamps
    end

    add_index :bars, :name
  end
end 