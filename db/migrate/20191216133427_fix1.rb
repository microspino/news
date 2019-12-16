class Fix1 < ActiveRecord::Migration[6.0]
  def change
    add_column :arxivs, :day_id, :integer
    add_column :gts, :day_id, :integer
    add_column :hns, :day_id, :integer
  end
end
