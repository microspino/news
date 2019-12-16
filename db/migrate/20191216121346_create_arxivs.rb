class CreateArxivs < ActiveRecord::Migration[6.0]
  def change
    create_table :arxivs do |t|
      t.string :title
      t.string :key
      t.timestamps
    end
  end
end
