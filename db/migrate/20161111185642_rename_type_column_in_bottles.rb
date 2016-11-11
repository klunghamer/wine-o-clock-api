class RenameTypeColumnInBottles < ActiveRecord::Migration[5.0]
  def change
    rename_column :bottles, :type, :red_or_white
  end
end
