class RemoveDesc < ActiveRecord::Migration[6.0]
  def change
    remove_column :gts, :desc
  end
end
