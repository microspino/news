class CreateGts < ActiveRecord::Migration[6.0]
  def change
    create_table :gts do |t|
      t.string :title
      t.string :desc
      t.string :key
      t.timestamps
    end
  end
end
